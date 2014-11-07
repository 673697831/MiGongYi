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
@property (nonatomic, assign) NSInteger playnodeIndex;
@property (nonatomic, strong) NSMutableDictionary *mutableDicBuff;
@property (nonatomic, assign) BOOL isfirstPlay;
/**
 *  走的是哪个路线? 正常和跳过第6关 坑啊
 */
@property (nonatomic, assign) BOOL boxingBranch;
//@property (nonatomic, copy) NSMutableArray *nodeArray;

@end
