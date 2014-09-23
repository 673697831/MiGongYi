//
//  MGYProjectRecent.m
//  MiGongYi
//
//  Created by megil on 9/23/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYProjectRecent.h"

@implementation MGYProjectRecent

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"projectId": @"project_id",
             @"summary": @"summary",
             @"type":@"type",
             @"readmoreUrl":@"readmore_url",
             @"coverImg":@"cover_img",
             @"showTime":@"show_time",
             };
}

@end
