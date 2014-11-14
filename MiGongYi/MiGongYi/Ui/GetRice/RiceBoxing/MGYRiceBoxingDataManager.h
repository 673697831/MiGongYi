//
//  MGYRiceBoxingDataManager.h
//  MiGongYi
//
//  Created by megil on 11/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGYBoxing.h"

@interface MGYRiceBoxingDataManager : NSObject

@property (nonatomic, strong, readonly) NSArray *arrayMonster;

+ (instancetype)manager;

@end
