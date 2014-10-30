//
//  MGYStoryPlayer.h
//  MiGongYi
//
//  Created by megil on 10/28/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGYStoryNode.h"

typedef void (^MGYStoryPlayCallback)();
typedef void (^MGYStorySelectCallback)(NSInteger);
typedef void (^MGYStoryGoAheadCallback)(MGYStorySelectCallback);


@interface MGYStoryPlayer : NSObject
{
    NSMutableArray *_progressArray;
    NSMutableArray *_nodes;
}

@property (nonatomic, strong) NSMutableDictionary *mutableDicBuff;
//@property (nonatomic, copy) NSArray *nodes;
@property (nonatomic, assign) BOOL isfirst;
@property (nonatomic, assign) NSInteger progress;
@property (nonatomic, strong) MGYStoryNode *playNode;
@property (nonatomic, strong) NSMutableArray *actionNodeArray;
@property (nonatomic, copy) NSString *storyName;
@property (nonatomic, strong, readonly) NSArray *progressArray;
@property (nonatomic, assign) NSInteger power;
@property (nonatomic, strong) NSLock *lock;

- (instancetype)initWithNodes:(NSArray *)nodes;

/**
 *  回调图片等信息
 */
- (void)play:(MGYStoryPlayCallback)callback;

- (void)goAhead:(MGYStoryGoAheadCallback)callback;

- (void)addPower:(NSInteger)num;

@end
