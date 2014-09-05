//
//  Util.m
//  MiGongYi
//
//  Created by megil on 9/4/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "Util.h"

@implementation Util
+(Util *)shareInstance
{
    static Util *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Util alloc] init];
    });
    return instance;
}
@end
