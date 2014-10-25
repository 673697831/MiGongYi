//
//  MGYURLSessionManager.m
//  MiGongYi
//
//  Created by megil on 10/22/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYURLSessionManager.h"

@interface MGYURLSessionManager ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, copy) NSURL *downloadFileURL;

@end

@implementation MGYURLSessionManager

- (instancetype)init
{
    return [self initWithSessionConfiguration:nil];
}

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super init];
    if (self) {
        if (!configuration) {
            configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        }
        self.session = [NSURLSession sessionWithConfiguration:configuration
                                                     delegate:self
                                                delegateQueue:nil];
        
    }
    return self;
}

- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(NSProgress *__autoreleasing *)progress
                                          destination:(NSURL *(^)(NSURL *, NSURLResponse *))destination
                                    completionHandler:(void (^)(NSURLResponse *, NSURL *, NSError *))completionHandler
{
    self.downloadTask = [self.session downloadTaskWithRequest:request];
    self.completionHandler = completionHandler;
    self.downloadTaskDidFinishDownloadingBlock = ^NSURL * (NSURLSession * __unused session, NSURLSessionDownloadTask *task, NSURL *location) {
        if (destination) {
            return destination(location, task.response);
        }
        
        return location;
    };

    return self.downloadTask;
}

+ (instancetype)manager
{
    return [MGYURLSessionManager new];
}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (self.completionHandler) {
        self.completionHandler(task.response, self.downloadFileURL, error);
    }
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    if (self.downloadTaskDidFinishDownloadingBlock) {
        self.downloadFileURL = self.downloadTaskDidFinishDownloadingBlock(session, downloadTask, location);
        if (self.downloadFileURL) {
            NSError *error = nil;
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:self.downloadFileURL error:&error];
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
    //NSLog(@"%f", (double)totalBytesWritten / (double)totalBytesExpectedToWrite);
}

@end
