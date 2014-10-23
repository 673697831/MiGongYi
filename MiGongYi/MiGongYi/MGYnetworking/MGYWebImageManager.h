//
//  MGYWebImageManager.h
//  MiGongYi
//
//  Created by megil on 10/23/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+MGYNetworking.h"

@interface MGYWebImageManager : NSObject

- (void)clearDisk;

+ (MGYWebImageManager *)shareInstance;

@end
