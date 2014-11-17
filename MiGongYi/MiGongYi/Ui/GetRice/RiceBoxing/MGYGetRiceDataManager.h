//
//  MGYRiceBoxingDataManager.h
//  MiGongYi
//
//  Created by megil on 11/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGYBoxingRecord.h"
#import "DataManager.h"

@interface MGYGetRiceDataManager : DataManager

@property (nonatomic, strong, readonly) MGYBoxingRecord *record;

- (AFHTTPRequestOperation *)requestForRiceBoxing:(NSInteger)family
                 monsterType:(MGYMonsterType)monsterType
                 coefficient:(CGFloat)coefficient;

+ (instancetype)manager;

@end
