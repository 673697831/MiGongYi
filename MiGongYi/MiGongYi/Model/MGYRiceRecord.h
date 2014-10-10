//
//  MGYRiceRecord.h
//  MiGongYi
//
//  Created by megil on 9/26/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

typedef NS_ENUM(NSInteger, MGYRiceRecordMode) {
    MGYRiceRecordModeInc = 1,
    MGYRiceRecordModeDec = 2,
};

@interface MGYRiceRecord : MTLModel <MTLJSONSerializing>

@property(nonatomic, copy) NSString *des;
@property(nonatomic, assign) MGYRiceRecordMode *incOrDec;
@property(nonatomic, assign) NSInteger riceNum;
@property(nonatomic, assign) NSInteger time;

@end
