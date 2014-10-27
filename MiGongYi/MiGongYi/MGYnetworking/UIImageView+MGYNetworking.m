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

@property(readwrite, nonatomic, strong, setter = mgy_setDownloadTask:) NSURLSessionDownloadTask *mgy_downloadTask;

@end

@implementation UIImageView (_MGYNetworking)

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
    [self mgy_setImageWithURL:url placeholderImage:nil];
}

- (void)mgy_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholderImage
{
    if (self.mgy_downloadTask) {
        [self.mgy_downloadTask cancel];
    }
    
    UIImage *image = [[MGYWebImageManager shareInstance] cachedImageExistsForURL:url] ?:[[MGYWebImageManager shareInstance] diskImageExistsForURL:url];
    if (image) {
        [self setImage:image];
    }else
    {
        [self setImage:placeholderImage];
        self.mgy_downloadTask = [[MGYWebImageManager shareInstance] downloadImageWithURL:url completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]];
            [self setImage:image];
            if (error) {
                NSLog(@"yyyyyyyy %@", error);
            }
            
        }];
        [self.mgy_downloadTask resume];
    }
}

@end
