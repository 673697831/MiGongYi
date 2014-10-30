//
//  MGYStoryNode.m
//  MiGongYi
//
//  Created by megil on 10/28/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYStoryNode.h"

@implementation MGYStoryBranch

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"identifier" : @"identifier",
             @"mapName" : @"mapName",
             @"title" : @"title",
             @"content" : @"content",
             };
}

@end

@implementation MGYStoryBuff

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"buffType" : @"buffType",
             @"buffState" : @"buffState",
             };
}

//+ (NSValueTransformer *)buffTypeJSONTransformer {
//    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:
//            @{@(0):@(MGYStoryBuffTypeShoes), @(1):@(MGYStoryBuffTypeBear),
//              @(2):@(MGYStoryBuffTypeJewel), @(3):@(MGYStoryBuffTypeMonster),
//              }
//            ];
//}
//
//+ (NSValueTransformer *)buffStateJSONTransformer {
//    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:
//            @{@(0):@(MGYStoryBuffStateTypeClose), @(1):@(MGYStoryBuffStateTypeOpen),
//              }
//            ];
//}

@end

@implementation MGYStoryNode

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"storyContent" : @"storyContent",
             @"branch" : @"branch",
             @"identifier" : @"identifier",
             @"nodeType" : @"nodeType",
             @"progress" : @"progress",
             @"arrayBuff" : @"arrayBuff",
             @"riceNum" : @"riceNum",
             };
}

+ (NSValueTransformer *)branchJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MGYStoryBranch class]];
}

+ (NSValueTransformer *)nodeTypeJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:
            @{@(0):@(MGYStoryNodeTypeHead), @(1):@(MGYStoryNodeTypeAction),
              @(2):@(MGYStoryNodeTypeTrail), @(3):@(MGYStoryNodeTypeNormalBrach),
              @(4):@(MGYStoryNodeTypeMiZhiBrach),@(5):@(MGYStoryNodeTypeBoxingBrach),
              }
            ];
}

+ (NSValueTransformer *)arrayBuffJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MGYStoryBuff class]];
}

@end
