//
//  MGYRiceBoxingDataManager.m
//  MiGongYi
//
//  Created by megil on 11/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceBoxingDataManager.h"

@interface MGYRiceBoxingDataManager ()
{
    NSMutableArray *_arrayMonster;
}


@end

@implementation MGYRiceBoxingDataManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (!self.arrayMonster) {
            _arrayMonster = [NSMutableArray array];
            
        }
    }
    return self;
}

+ (instancetype)manager
{
    static MGYRiceBoxingDataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MGYRiceBoxingDataManager new];
    });
    return instance;
}

@end
