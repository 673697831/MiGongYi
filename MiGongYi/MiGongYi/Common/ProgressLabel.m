//
//  ProgressLabel.m
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "ProgressLabel.h"
#import "UIColor+Expanded.h"

@implementation ProgressLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame BackgroundFrame:(CGRect)backgroundFrame
{
    self = [super init];
    self.backgroundColor = [UIColor clearColor];
    //CGFloat height = 12 / 2;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = backgroundFrame;
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithHexString:@"dddddd"].CGColor,
                       (id)[UIColor colorWithHexString:@"dddddd"].CGColor,
                       nil];
    gradient.cornerRadius = frame.size.height/2;
    [self.layer insertSublayer:gradient atIndex:0];
    
    CAGradientLayer *gradient2 = [CAGradientLayer layer];
    gradient2.frame = frame;
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient2.colors = [NSArray arrayWithObjects:
                        (id)[UIColor colorWithHexString:@"f16400"].CGColor,
                        (id)[UIColor colorWithHexString:@"f17d00"].CGColor,
                        nil];
    gradient2.cornerRadius = frame.size.height/2;
    [self.layer insertSublayer:gradient2 atIndex:1];
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
