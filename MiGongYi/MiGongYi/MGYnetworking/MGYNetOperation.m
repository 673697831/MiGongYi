//
//  MGYNetOperation.m
//  MiGongYi
//
//  Created by megil on 10/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYNetOperation.h"
#import "MGYNetResponseSerializer.h"

@interface MGYNetOperation ()

@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSOutputStream *outputStream;
@property (nonatomic, strong) NSData *responseData;
@property (nonatomic, strong) NSSet *runLoopModes;
@property (nonatomic, strong) MGYNetResponseSerializer *responseSerializer;

@end

@implementation MGYNetOperation

+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"MGYNetworking"];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+ (NSThread *)networkRequestThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    
    return _networkRequestThread;
}

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest
{
    NSParameterAssert(urlRequest);
    
    self = [super init];
    if (self) {
		self.request = urlRequest;
        self.responseSerializer = [MGYNetResponseSerializer serializer];
        self.runLoopModes = [NSSet setWithObject:NSRunLoopCommonModes];
    }
    return self;
}

- (void)dealloc {
    if (_outputStream) {
        [_outputStream close];
        _outputStream = nil;
    }
}

- (void)start
{
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
//    
//    [connection start];
    
    if ([self isCancelled]) {
        [self performSelector:@selector(cancelConnection) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    } else if ([self isReady]) {
        
        [self performSelector:@selector(operationDidStart) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    }
}

- (void)operationDidStart {
    if (![self isCancelled]) {
        self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        for (NSString *runLoopMode in self.runLoopModes) {
            [self.connection scheduleInRunLoop:runLoop forMode:runLoopMode];
            [self.outputStream scheduleInRunLoop:runLoop forMode:runLoopMode];
        }
        
        [self.connection start];
    }
}

- (void)cancelConnection {
    NSDictionary *userInfo = nil;
    if ([self.request URL]) {
        userInfo = [NSDictionary dictionaryWithObject:[self.request URL] forKey:NSURLErrorFailingURLErrorKey];
    }
    NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCancelled userInfo:userInfo];
    
    if (![self isFinished]) {
        if (self.connection) {
            [self.connection cancel];
            [self performSelector:@selector(connection:didFailWithError:) withObject:self.connection withObject:error];
        } else {
            // Accomodate race condition where `self.connection` has not yet been set before cancellation
            //self.error = error;
            //[self finish];
        }
    }
}

- (NSOutputStream *)outputStream {
    if (!_outputStream) {
        self.outputStream = [NSOutputStream outputStreamToMemory];
    }
    
    return _outputStream;
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection __unused *)connection
    didReceiveData:(NSData *)data
{
    NSUInteger length = [data length];
    while (YES) {
        NSInteger totalNumberOfBytesWritten = 0;
        if ([self.outputStream hasSpaceAvailable]) {
            const uint8_t *dataBuffer = (uint8_t *)[data bytes];
            
            NSInteger numberOfBytesWritten = 0;
            while (totalNumberOfBytesWritten < (NSInteger)length) {
                numberOfBytesWritten = [self.outputStream write:&dataBuffer[(NSUInteger)totalNumberOfBytesWritten] maxLength:(length - (NSUInteger)totalNumberOfBytesWritten)];
                if (numberOfBytesWritten == -1) {
                    break;
                }
                
                totalNumberOfBytesWritten += numberOfBytesWritten;
            }
            
            break;
        }
        
        if (self.outputStream.streamError) {
            [self.connection cancel];
            [self performSelector:@selector(connection:didFailWithError:) withObject:self.connection withObject:self.outputStream.streamError];
            return;
        }
    }

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.outputStream close];
    if (self.responseData) {
        self.outputStream = nil;
    }
    if (self.failure) {
        self.failure(self, error);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection __unused *)connection {
    self.responseData = [self.outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    [self.outputStream close];
    if (self.responseData) {
        self.outputStream = nil;
    }
    
    self.connection = nil;
    
    NSError *error = nil;
    if (self.success) {
        self.success(self, [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&error]);
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.response = response;
    
    [self.outputStream open];
}

@end
