//
//  MGYStoryPlayer.h
//  MiGongYi
//
//  Created by megil on 10/28/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MGYStoryNode.h"
#import "MGYTotalWalk.h"
#import "MGYStory.h"

typedef NS_ENUM(NSInteger, MGYStoryLockState) {
    MGYStoryLockStateLocked,
    MGYStoryLockStateUnLocked,
};


typedef void (^MGYStorySelectCallback)(NSInteger);
/**
 *  第一次播放剧情时候显示剧情简介
 *
 *  @param  剧情简介
 */
typedef void (^MGYStoryFirstPlayCallback)(NSString *);
typedef void (^MGYStoryPlayCallback)(NSString *manImagePath);
/**
 *  go返回
 *
 *  @param                        返回节点信息 有的显示剧情
 *  @param MGYStorySelectCallback 选择返回
 *  @param                        人物图(对应BUFF)
 *  @param BOOL                   是否显示装备TIPS
 */
typedef void (^MGYStoryGoAheadCallback)(MGYStorySelectCallback);
typedef void (^MGYStoryAddPowerCallback)();


@interface MGYStoryPlayer : NSObject<CLLocationManagerDelegate>

@property (nonatomic, weak, readonly) MGYStoryNode *playNode;
@property (nonatomic, strong, readonly) NSArray *mutableProgress;
@property (nonatomic, strong, readonly) MGYTotalWalk *totalWalk;
@property (nonatomic, strong, readonly) MGYStory *story;
@property (nonatomic, assign, readonly) BOOL isplaying;
@property (nonatomic, weak) MGYStoryAddPowerCallback addPowerCallback;

/**
 *  回调图片等信息
 */
- (void)play:(MGYStoryPlayCallback)callback firstCallback:(MGYStoryFirstPlayCallback)firstCallback;

- (void)goAhead:(MGYStoryGoAheadCallback)callback;

- (void)resetStory:(NSString *)storyName;

- (MGYStoryLockState)getMapLockState:(NSString *)mapName;

- (NSString *)getStoryContent:(NSString *)storyName
                        index:(NSInteger)index;

- (NSString *)storyDescription;

- (BOOL)isMizhiNode;

- (BOOL)isBoxingNode;

- (BOOL)isBoxingBranch;

- (BOOL)isBoxingAndSelectNode;

- (void)openBoxingBranch;

- (NSString *)getNextStory;

- (NSString *)getCurStoryName;

+ (instancetype)defaultPlayer;

+ (void)enterBackground;

+ (void)outBackground;

@end

