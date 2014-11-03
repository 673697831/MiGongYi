//
//  MGYTotalWalk.h
//  MiGongYi
//
//  Created by megil on 11/2/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface MGYTotalWalk : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) long long timeSp;
@property (nonatomic, assign) long long curStep;
@property (nonatomic, assign) long long totalStep;
@property (nonatomic, assign) CGFloat power;

@end
