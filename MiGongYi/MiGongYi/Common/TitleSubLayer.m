//
//  TitleSubLayer.m
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "TitleSubLayer.h"
#import "UIColor+Expanded.h"

@implementation TitleSubLayer
- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    self.frame = frame;
    self.startPoint = CGPointMake(0, 0.5);
    self.endPoint = CGPointMake(1, 0.5);
    self.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithHexString:@"f16400"].CGColor,
                       (id)[UIColor colorWithHexString:@"f17d00"].CGColor,
                       nil];
    return self;
}
@end
