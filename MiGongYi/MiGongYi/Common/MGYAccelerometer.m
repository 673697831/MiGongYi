//
//  MGYAccelerometer.m
//  MiGongYi
//
//  Created by megil on 11/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYAccelerometer.h"

@interface MGYAccelerometer ()

@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation MGYAccelerometer

- (instancetype)init
{
    self = [super init];
    if(self){
        self.motionManager = [CMMotionManager new];
        self.motionManager.accelerometerUpdateInterval = 1./60;
    }
    return self;
}

- (void)start
{
    [self.motionManager startAccelerometerUpdates];
}

- (void)stop
{
    [self.motionManager stopAccelerometerUpdates];
}

- (CGFloat)x
{
    return self.motionManager.accelerometerData.acceleration.x;
}

- (CGFloat)y
{
    return self.motionManager.accelerometerData.acceleration.y;
}

- (CGFloat)z
{
    return self.motionManager.accelerometerData.acceleration.z;
}

- (void)dealloc
{
    if(self.motionManager){
        [self stop];
    }
}

+ (MGYAccelerometer *)shareInstance
{
    static MGYAccelerometer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MGYAccelerometer new];
    });
    return instance;
    
}

@end
