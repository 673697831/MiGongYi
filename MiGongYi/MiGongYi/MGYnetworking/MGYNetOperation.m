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
@property (nonatomic, strong) MGYNetResponseSerializer *responseSerializer;

@end

@implementation MGYNetOperation

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest
{
    NSParameterAssert(urlRequest);
    
    self = [super init];
    if (self) {
		self.request = urlRequest;
        self.responseSerializer = [MGYNetResponseSerializer serializer];
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
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
    
    [connection start];
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
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.totalBytesRead += (long long)length;
//        
//        if (self.downloadProgress) {
//            self.downloadProgress(length, self.totalBytesRead, self.response.expectedContentLength);
//        }
//    });
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
    
    //[self finish];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.response = response;
    
    [self.outputStream open];
}

@end
