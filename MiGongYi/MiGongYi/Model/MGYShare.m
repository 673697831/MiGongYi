//
//  MGYMiZhiShare.m
//  MiGongYi
//
//  Created by megil on 10/11/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYShare.h"

@implementation MGYShare

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title": @"title",
             @"summary": @"summary",
             @"imgUrl": @"img_url",
             @"url": @"url",
             };
}

@end
