//
//  UIImageView+MGYNetworking.m
//  MiGongYi
//
//  Created by megil on 10/22/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "UIImageView+MGYNetworking.h"
#import "AFNetworking.h"
#import <objc/runtime.h>

@interface UIImageView (_MGYNetworking)

//@property (readwrite, nonatomic, strong, setter = mgy_setImageRequestOperation:) AFHTTPRequestOperation *af_imageRequestOperation;

@property(readwrite, nonatomic, strong, setter = mgy_setDownloadTask:) NSURLSessionDownloadTask *mgy_downloadTask;

@end

@implementation UIImageView (_MGYNetworking)
//@dynamic downloadTask;

- (NSURLSessionDownloadTask *)mgy_downloadTask {
    return (NSURLSessionDownloadTask *)objc_getAssociatedObject(self, @selector(mgy_downloadTask));
}

- (void)mgy_setDownloadTask:(NSURLSessionDownloadTask *)downloadTask
{
    objc_setAssociatedObject(self, @selector(mgy_downloadTask), downloadTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIImageView (MGYNetworking)

- (void)mgy_setImageWithURL:(NSURL *)url
{
    
    if (self.mgy_downloadTask) {
        [self.mgy_downloadTask cancel];
    }
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //MGYURLSessionManager *manager = [MGYURLSessionManager manager];
    
    //NSURL *URL = [NSURL URLWithString:@"https://github.com/Volcore/waaaghtv/archive/master.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.mgy_downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:[self CachesDic]];
        NSURL *docURL = [documentsDirectoryURL URLByAppendingPathComponent:[self randomString]];
        //return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        return docURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        //NSLog(@"File downloaded to: %@", filePath);
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]];
        [self setImage:image];
        if (error) {
            NSLog(@"yyyyyyyy %@", error);
        }
    }];
    [self.mgy_downloadTask resume];
}

- (NSString *)CachesDic
{
    return [UIImageView CachesDic];
}

- (NSString *)randomString
{
    int NUMBER_OF_CHARS = 10;
    char data[NUMBER_OF_CHARS];
    for (int x=0;x<NUMBER_OF_CHARS; x ++)
    {
        data[x] = 'A' + arc4random_uniform(26);
    }
    NSString *dataPoint = [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
    return dataPoint;
}

+ (NSString *)CachesDic
{
    BOOL isDic = YES;
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [NSString stringWithFormat:@"%@/Caches/MGYWebImageCache", libPath];
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:filePath
                                                        isDirectory:&isDic];
    if (!existed) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    return filePath;
}


@end
