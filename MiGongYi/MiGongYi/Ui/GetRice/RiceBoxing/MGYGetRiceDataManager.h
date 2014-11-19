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

//- (NSDictionary *)riceMoveLevelRecord;

- (MGYTotalWalk *)totalWalk;

- (void)addStep:(NSInteger)step;

- (void)addPower:(NSInteger)power;

+ (instancetype)manager;

@end
