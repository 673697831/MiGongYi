//
//  PersonalDetails.m
//  MiGongYi
//
//  Created by megil on 9/15/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "PersonalDetails.h"

@implementation PersonalDetails

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
