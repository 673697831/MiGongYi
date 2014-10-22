//
//  MGYURLSessionManager.h
//  MiGongYi
//
//  Created by megil on 10/22/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGYURLSessionManager : NSObject<NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate>

typedef void (^MGYURLSessionTaskCompletionHandler)(NSURLResponse *response, id responseObject, NSError *error);
typedef NSURL * (^MGYURLSessionDownloadTaskDidFinishDownloadingBlock)(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, NSURL *location);

@property (nonatomic, copy) MGYURLSessionTaskCompletionHandler completionHandler;
@property (nonatomic, copy) MGYURLSessionDownloadTaskDidFinishDownloadingBlock downloadTaskDidFinishDownloadingBlock;

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration;

- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(NSProgress * __autoreleasing *)progress
                                          destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                    completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;
+ (instancetype)manager;

@end
