//
//  MGYRiceBoxingDataManager.h
//  MiGongYi
//
//  Created by megil on 11/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGYBoxingRecord.h"
#import "MGYRiceMoveLevelRecord.h"
#import "DataManager.h"
#import "MGYStory.h"

@interface MGYGetRiceDataManager : DataManager

@property (nonatomic, strong, readonly) MGYBoxingRecord *record;

- (AFHTTPRequestOperation *)requestForRiceBoxing:(NSInteger)family
                 monsterType:(MGYMonsterType)monsterType
                 coefficient:(CGFloat)coefficient;

- (AFHTTPRequestOperation *)requestForRiceMove:(NSInteger)storyIndex
                                     nodeIndex:(NSInteger)nodeIndex;

- (AFHTTPRequestOperation *)requestForRiceMoveFromLocal;

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

- (MGYTotalWalk *)totalWalk;

- (BOOL)bshowRiceMoveHelp;

- (void)addStep:(NSInteger)step;

- (void)addPower:(CGFloat)power;

- (void)resetPower;

+ (instancetype)manager;

@end
