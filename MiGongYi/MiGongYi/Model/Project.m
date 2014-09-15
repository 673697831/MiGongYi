//
//  Project.m
//  MiGongYi
//
//  Created by megil on 9/9/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "Project.h"

@implementation Project

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"projectId": @"project_id",
             @"coverImg": @"cover_img",
             @"title": @"title",
             @"riceDonate": @"rice_donate",
             @"progress": @"progress",
             @"favNum": @"fav_num",
             @"joinMemberNum":@"join_member_num",
             @"status": @"status",
             };
}

@end
