//
//  MGYProtocolRiceBoxingObtain.h
//  MiGongYi
//
//  Created by megil on 11/26/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface MGYProtocolRiceBoxingObtain : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) NSInteger rice;
@property (nonatomic, assign) NSInteger remainTimes;
@property (nonatomic, strong) NSArray *arrayProcess;
@property (nonatomic, copy) NSString *dailyTips;

@end
