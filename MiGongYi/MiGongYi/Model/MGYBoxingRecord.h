//
//  MGYBoxing.h
//  MiGongYi
//
//  Created by megil on 11/13/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

typedef NS_ENUM(NSInteger, MGYMonsterType) {
    MGYMonsterTypeSmall,
    MGYMonsterTypeMiddle,
    MGYMonsterTypeLarge,
};

typedef NS_ENUM(NSInteger, MGYMonsterStatus) {
    MGYMonsterStatusLocked,
    MGYMonsterStatusUnLocked,
};


@interface MGYMonster :MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *backgroundImagePath;
@property (nonatomic, assign) NSInteger fightTimes;
@property (nonatomic, assign) NSInteger monsterId;
@property (nonatomic, assign) MGYMonsterType monsterType;
@property (nonatomic, copy) NSString *monsterName;
@property (nonatomic, copy) NSString *rateContent;
@property (nonatomic, assign) NSInteger maxHp;
@property (nonatomic, assign) NSInteger riceNum;
@property (nonatomic, copy) NSString *skillContent;
@property (nonatomic, copy) NSString *levelContent;
@property (nonatomic, copy) NSString *storyContent;
@property (nonatomic, copy) NSString *gayImagePath;
@property (nonatomic, copy) NSString *normalImagePath;
@property (nonatomic, copy) NSString *familyName;
@property (nonatomic, copy) NSString *condition;
@property (nonatomic, assign) MGYMonsterStatus monsterStatus;
@property (nonatomic, assign) NSInteger time;

@end

@interface MGYBoxingRecord : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) NSInteger fightTimes;
@property (nonatomic, assign) long long timesp;
@property (nonatomic, strong) NSArray *arrayMonster;
@property (nonatomic, assign) NSInteger monsterId;
@property (nonatomic, assign) NSInteger curHp;
@property (nonatomic, assign) NSInteger bossId;
@property (nonatomic, assign) NSInteger bossHp;
@property (nonatomic, assign) NSInteger smallTimes;
@property (nonatomic, assign) NSInteger middleTimes;

@end
