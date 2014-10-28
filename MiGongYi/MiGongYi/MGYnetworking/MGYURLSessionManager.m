//
//  MGYURLSessionManager.m
//  MiGongYi
//
//  Created by megil on 10/22/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYURLSessionManager.h"

static dispatch_queue_t url_session_manager_processing_queue() {
    static dispatch_queue_t mgy_url_session_manager_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgy_url_session_manager_processing_queue = dispatch_queue_create("com.mgy.networking.session.manager.processing", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return mgy_url_session_manager_processing_queue;
}

static dispatch_group_t url_session_manager_completion_group() {
    static dispatch_group_t af_url_session_manager_completion_group;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        af_url_session_manager_completion_group = dispatch_group_create();
    });
    
    return af_url_session_manager_completion_group;
}

@interface MGYURLSessionManagerTaskDelegate : NSObject

@property (nonatomic, strong) NSProgress *progress;
@property (nonatomic, copy) NSURL *downloadFileURL;
@property (nonatomic, copy) MGYURLSessionDownloadTaskDidFinishDownloadingBlock downloadTaskDidFinishDownloading;
@property (nonatomic, copy) MGYURLSessionTaskCompletionHandler completionHandler;

@end

@implementation MGYURLSessionManagerTaskDelegate
@end

@interface MGYURLSessionManager ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, strong) NSMutableDictionary *mutableTaskDelegatesKeyedByTaskIdentifier;

- (void)addDelegateForDownloadTask:(NSURLSessionDownloadTask *)downloadTask
                          progress:(NSProgress * __autoreleasing *)progress
                       destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                 completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

- (void)setDelegate:(MGYURLSessionManagerTaskDelegate *)delegate
            forTask:(NSURLSessionTask *)task;

@end

@implementation MGYURLSessionManager

- (instancetype)init
{
    return [self initWithSessionConfiguration:nil];
}

#pragma mark -
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super init];
    if (self) {
        if (!configuration) {
            configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        }
    
        self.mutableTaskDelegatesKeyedByTaskIdentifier = [NSMutableDictionary dictionary];
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
        
        self.session = [NSURLSession sessionWithConfiguration:configuration
                                                     delegate:self
                                                delegateQueue:self.operationQueue];
        
    }
    return self;
}

- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(NSProgress *__autoreleasing *)progress
                                          destination:(NSURL *(^)(NSURL *, NSURLResponse *))destination
                                    completionHandler:(void (^)(NSURLResponse *, NSURL *, NSError *))completionHandler
{
     NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithRequest:request];
    
    [self addDelegateForDownloadTask:downloadTask
                            progress:0
                         destination:destination
                   completionHandler:completionHandler];
    
    return downloadTask;
}

#pragma mark -
- (void)addDelegateForDownloadTask:(NSURLSessionDownloadTask *)downloadTask
                          progress:(NSProgress * __autoreleasing *)progress
                       destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                 completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    MGYURLSessionManagerTaskDelegate *delegate = [[MGYURLSessionManagerTaskDelegate alloc] init];
    delegate.completionHandler = completionHandler;
    delegate.downloadTaskDidFinishDownloading = ^NSURL * (NSURLSession * __unused session, NSURLSessionDownloadTask *task, NSURL *location) {
        if (destination) {
            return destination(location, task.response);
        }
        
        return location;
    };
    
    if (progress) {
        *progress = delegate.progress;
    }
    
    [self setDelegate:delegate forTask:downloadTask];
}

- (void)setDelegate:(MGYURLSessionManagerTaskDelegate *)delegate
            forTask:(NSURLSessionTask *)task
{
    NSParameterAssert(task);
    NSParameterAssert(delegate);
    
    [self.lock lock];

    self.mutableTaskDelegatesKeyedByTaskIdentifier[@(task.taskIdentifier)] = delegate;
    
    [self.lock unlock];
}

#pragma mark -
+ (instancetype)manager
{
    return [MGYURLSessionManager new];
}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    dispatch_sync(url_session_manager_processing_queue(), ^{
        dispatch_group_async(url_session_manager_completion_group(), dispatch_get_main_queue(), ^{
            MGYURLSessionManagerTaskDelegate *deletgate = self.mutableTaskDelegatesKeyedByTaskIdentifier[@(task.taskIdentifier)];
            if (deletgate && deletgate.completionHandler) {
                deletgate.completionHandler(task.response, deletgate.downloadFileURL, error);
                [self.lock lock];
                [self.mutableTaskDelegatesKeyedByTaskIdentifier removeObjectForKey:@(task.taskIdentifier)];
                [self.lock unlock];
            }
        });
    });
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    MGYURLSessionManagerTaskDelegate *deletgate = self.mutableTaskDelegatesKeyedByTaskIdentifier[@(downloadTask.taskIdentifier)];
    if (deletgate && deletgate.downloadTaskDidFinishDownloading) {
        NSURL *downloadFileURL =
        deletgate.downloadTaskDidFinishDownloading(session, downloadTask, location);
        if (downloadFileURL) {
            NSError *error = nil;
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:downloadFileURL error:&error];
            deletgate.downloadFileURL = downloadFileURL;
        }
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{

}

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //NSLog(@"%f", (float)totalBytesWritten / (float)totalBytesExpectedToWrite);
}

@end
