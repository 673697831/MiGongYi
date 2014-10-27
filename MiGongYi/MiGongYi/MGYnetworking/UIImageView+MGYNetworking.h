//
//  UIImageView+MGYNetworking.h
//  MiGongYi
//
//  Created by megil on 10/22/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGYWebImageManager.h"

@interface UIImageView (MGYNetworking)

- (void)mgy_setImageWithURL:(NSURL *)url;

- (void)mgy_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholderImage;

@end
