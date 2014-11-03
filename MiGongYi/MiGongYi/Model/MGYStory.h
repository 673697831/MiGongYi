//
//  MGYStory.h
//  MiGongYi
//
//  Created by megil on 11/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
#import "MGYStoryNode.h"
/**
 *  存放当前剧情进度
 */
@interface MGYStory : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) NSInteger storyIndex;
@property (nonatomic, copy) NSString *storyName;
@property (nonatomic, assign) NSInteger progress;
@property (nonatomic, copy) NSMutableArray *nodeArray;

@end
