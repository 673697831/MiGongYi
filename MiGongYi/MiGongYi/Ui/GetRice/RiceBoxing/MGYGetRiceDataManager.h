//
//  MGYRiceBoxingDataManager.h
//  MiGongYi
//
//  Created by megil on 11/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MGYBoxingRecord.h"
#import "MGYRiceMoveLevelRecord.h"
#import "DataManager.h"
#import "MGYStory.h"
#import "MGYTotalWalk.h"
#import "MGYProtocolRiceBoxingObtain.h"
#import "MGYPublicFunction.h"

@class DataManager;

@interface MGYGetRiceDataManager : NSObject

@property (nonatomic, strong, readonly) MGYProtocolRiceBoxingObtain *riceBoxingObtain;
@property (nonatomic, assign, readonly) NSInteger remainTimes;

@property (nonatomic, strong) AFHTTPRequestOperation *lastOp;

typedef void (^riceBoxingHitCallback)();

- (instancetype)initWithManager:(DataManager *)manager;

- (AFHTTPRequestOperation *)requestForRiceBoxing:(NSInteger)family
                 monsterType:(MGYMonsterType)monsterType
                 coefficient:(CGFloat)coefficient
                     success:(MGYSuccess)success
                     failure:(MGYFailure)failure;

- (AFHTTPRequestOperation *)requestForRiceMove:(NSInteger)storyIndex
                                     nodeIndex:(NSInteger)nodeIndex;

- (AFHTTPRequestOperation *)requestForRiceMoveFromLocal;

- (AFHTTPRequestOperation *)requestForRiceMoveLevels;

- (void)saveRiceMoveLevelRecord:(NSInteger)storyIndex
                      nodeIndex:(NSInteger)nodeIndex;

- (NSString *)dateString:(NSInteger)storyIndex
                   index:(NSInteger)index;

- (MGYStory *)story;

- (void)synStory;

- (void)saveStoryName:(NSString *)storyName;

- (void)saveStoryProgress:(NSInteger)progress;

- (void)saveStoryPlaynodeIndex:(NSInteger)index;

- (void)saveStoryBuff:(NSArray *)arrayBuff;

- (void)saveStoryIsfirstPlay:(BOOL)isfirstPlay;

- (void)saveStoryIsplaying:(BOOL)isplaying;

- (void)saveStoryBoxingBranch:(BOOL)isBoxingBranch;

- (NSArray *)arrayRiceBoxingMonster;

//- (CGFloat)riceBoxingMonsterCurHp;

- (CGFloat)riceBoxingMonsterProgress;

- (void)hitMonster:(MGYSuccess)success
              failure:(MGYFailure)failure
    timeoutFailure:(MGYRiceTimeOutFailure)timoutFailure;
//riceBoxingHitCallback:(riceBoxingHitCallback)riceBoxingHitCallback;

- (MGYMonster *)riceBoxingCurMonster;

- (void)resetMonster;

- (void)riceBoxingResetBoss;

- (NSInteger)riceBoxingSmallTimes;

- (NSInteger)riceBoxingMiddleTimes;

- (void)resetRiceBoxingTimes;

- (void)riceBoxingUnLockMonster:(NSInteger)monsterId;

- (void)setRiceRiceBoxingTimeBlock:(MGYRiceBoxingTimeBlock)timeBlock;

- (NSInteger)getRiceBoxingBossRemainTime;

- (NSInteger)getRiceBoxingFollowId;

- (void)setRiceBoxingFollowId:(NSInteger)followId;

- (BOOL)checkMiChatCoefficient;

- (BOOL)checkRiceMoveCoefficient;

- (BOOL)checkGetRiceCoefficient;

- (BOOL)checkRiceBoxingCoefficient;

- (BOOL)checkMiZhiCoefficient;

- (BOOL)checkRiceRateCoefficient;

- (MGYTotalWalk *)totalWalk;

- (BOOL)bshowRiceMoveHelp;

- (void)addStep:(NSInteger)step;

- (void)addPower:(CGFloat)power;

- (void)resetPower;

//+ (instancetype)manager;

@end
