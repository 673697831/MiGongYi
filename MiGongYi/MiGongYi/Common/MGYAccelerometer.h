//
//  MGYAccelerometer.h
//  MiGongYi
//
//  Created by megil on 11/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface MGYAccelerometer : NSObject

+ (MGYAccelerometer *)shareInstance;

- (void)start;

- (void)stop;

- (CGFloat)x;

- (CGFloat)y;

- (CGFloat)z;

@end
