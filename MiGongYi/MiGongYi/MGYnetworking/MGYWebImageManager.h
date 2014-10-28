//
//  MGYWebImageManager.h
//  MiGongYi
//
//  Created by megil on 10/23/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGYWebImageManager : NSObject

- (void)clearDisk;

- (NSURLSessionDownloadTask *)downloadImageWithURL:(NSURL *)url
           completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

- (UIImage *)cachedImageExistsForURL:(NSURL *)url;

- (UIImage *)diskImageExistsForURL:(NSURL *)url;

+ (MGYWebImageManager *)shareInstance;

@end
