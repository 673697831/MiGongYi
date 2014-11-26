//
//  MGYRiceBoxingMonsterRate.h
//  MiGongYi
//
//  Created by megil on 11/25/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface MGYRiceBoxingMonsterRate :MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) NSInteger monsterId;
@property (nonatomic, assign) NSInteger rate;

@end
