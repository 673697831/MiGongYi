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

@class DataManager;

@interface MGYGetRiceDataManager : NSObject

typedef void (^MGYRiceBoxingKillSuccess)();
typedef void (^MGYRiceBoxingKillFailure)();
typedef void (^MGYRiceBoxingTimeBlock)();

- (instancetype)initWithManager:(DataManager *)manager;

- (AFHTTPRequestOperation *)requestForRiceBoxing:(NSInteger)family
                 monsterType:(MGYMonsterType)monsterType
                 coefficient:(CGFloat)coefficient;

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

- (CGFloat)riceBoxingMonsterCurHp;

- (CGFloat)hitMonster:(MGYRiceBoxingKillSuccess)success
              failure:(MGYRiceBoxingKillFailure)failure;

- (MGYMonster *)riceBoxingCurMonster;

- (void)resetMonster;

- (void)riceBoxingResetBoss;

- (NSInteger)riceBoxingSmallTimes;

- (NSInteger)riceBoxingMiddleTimes;

- (void)resetRiceBoxingTimes;

- (void)setRiceRiceBoxingTimeBlock:(MGYRiceBoxingTimeBlock)timeBlock;

- (NSInteger)getRiceBoxingBossRemainTime;

- (MGYTotalWalk *)totalWalk;

- (BOOL)bshowRiceMoveHelp;

- (void)addStep:(NSInteger)step;

- (void)addPower:(CGFloat)power;

- (void)resetPower;

//+ (instancetype)manager;

@end
