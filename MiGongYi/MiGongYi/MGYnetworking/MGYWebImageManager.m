//
//  MGYWebImageManager.m
//  MiGongYi
//
//  Created by megil on 10/23/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYWebImageManager.h"

@implementation MGYWebImageManager

- (void)clearDisk
{
    
//    NSString *extension = @"m4r";
    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:[UIImageView CachesDic] error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        //if ([[filename pathExtension] isEqualToString:extension]) {
            
            [fileManager removeItemAtPath:[[UIImageView CachesDic] stringByAppendingPathComponent:filename] error:NULL];
        //}
    }
}

+ (MGYWebImageManager *)shareInstance
{
    static MGYWebImageManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MGYWebImageManager new];
    });
    return instance;
}

@end
