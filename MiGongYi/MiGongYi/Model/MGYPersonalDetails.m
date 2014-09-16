//
//  PersonalDetails.m
//  MiGongYi
//
//  Created by megil on 9/15/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYPersonalDetails.h"

@implementation MGYPersonalDetails

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"uid": @"uid",
             @"sex": @"sex",
             @"nickname": @"nickname",
             @"passport": @"passport",
             @"avatar": @"avatar",
             };
}

@end
