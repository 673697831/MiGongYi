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

//- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
//    self = [super initWithDictionary:dictionaryValue error:error];
//    if (self == nil) return nil;
//    
//    // Store a value that needs to be determined locally upon initialization.
//    //_retrievedAt = [NSDate date];
//    
//    return self;
//}

+ (NSValueTransformer *)URLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

//+ (NSValueTransformer *)stateJSONTransformer {
//    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
//                                                                           @"open": @(GHIssueStateOpen),
//                                                                           @"closed": @(GHIssueStateClosed)
//                                                                           }];
//}
//
//+ (NSValueTransformer *)assigneeJSONTransformer {
//    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:GHUser.class];
//}
//
//+ (NSValueTransformer *)updatedAtJSONTransformer {
//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
//        return [self.dateFormatter dateFromString:str];
//    } reverseBlock:^(NSDate *date) {
//        return [self.dateFormatter stringFromDate:date];
//    }];
//}
@end
