//
//  MGYWebImageManager.m
//  MiGongYi
//
//  Created by megil on 10/23/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYWebImageManager.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>

@interface MGYImageCache : NSCache
@end

@implementation MGYImageCache

@end

@interface MGYWebImageManager ()

@property (nonatomic, strong) NSCache *imageCache;
//@property (nonatomic ,strong) NSMutableDictionary *imageCache;
@property (nonatomic, strong) AFURLSessionManager *afURLSessionManager;

@end

@implementation MGYWebImageManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageCache = [NSCache new];
        //self.imageCache = [NSMutableDictionary dictionary];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.afURLSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return self;
}

- (NSURLSessionDownloadTask *)downloadImageWithURL:(NSURL *)url
           completionHandler:(void (^)(NSURLResponse *, NSURL *, NSError *))completionHandler
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [self.afURLSessionManager downloadTaskWithRequest:request
                                                                     progress:nil
                                                                  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [self docURL:url];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        //NSLog(@"File downloaded to: %@", filePath);
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]];
        if (image) {
            [self setCachedImage:url image:image];
        }
        completionHandler(response, filePath, error);
    }];
    return downloadTask;
}

- (UIImage *)cachedImageExistsForURL:(NSURL *)url
{
    return [self.imageCache objectForKey:[self cacheKeyForURL:url]];
}

- (void)setCachedImage:(NSURL *)url image:(UIImage *)image
{
    [self.imageCache setObject:image forKey:[self cacheKeyForURL:url]];
}

- (UIImage *)diskImageExistsForURL:(NSURL *)url
{
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[self docURL:url]]];
}

- (void)setDiskImage:(NSURL *)url Image:(UIImage *)Image
{

}

- (NSURL *)docURL:(NSURL *)url
{
    NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:[self.class CachesDic]];
    NSURL *docURL = [documentsDirectoryURL URLByAppendingPathComponent:[self cacheKeyForURL:url]];
    //return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    return docURL;
}

- (NSString *)cacheKeyForURL:(NSURL *)url
{
    const char *str = [[url absoluteString] UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return filename;
}

- (void)clearDisk
{
    
//    NSString *extension = @"m4r";
    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:[self.class CachesDic] error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        //if ([[filename pathExtension] isEqualToString:extension]) {
            
            [fileManager removeItemAtPath:[[self.class CachesDic] stringByAppendingPathComponent:filename] error:NULL];
        //}
    }
}

+ (MGYWebImageManager *)shareInstance
{
    static MGYWebImageManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MGYWebImageManager alloc] init];
    });
    return instance;
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
