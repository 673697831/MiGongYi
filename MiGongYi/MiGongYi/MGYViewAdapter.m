//
//  MGYViewAdapter.m
//  MiGongYi
//
//  Created by megil on 9/25/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYViewAdapter.h"

@implementation MGYViewAdapter

+ (CGFloat)rateHeight
{
    CGFloat originHeight = 1136 / 2 - 20 - 40 - 49;
    CGFloat appHeight =  [UIScreen mainScreen].bounds.size.height - 20 - 40 - 49;
    return appHeight / originHeight;
}

@end
