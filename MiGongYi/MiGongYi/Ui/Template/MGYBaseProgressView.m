//
//  MGYBaseProgressView.m
//  MiGongYi
//
//  Created by megil on 9/12/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYBaseProgressView.h"
#import "UIColor+Expanded.h"

@interface MGYBaseProgressView ()

@end

@implementation MGYBaseProgressView

- (void)drawGradientLayer:(CGRect)rect
{
    [self.programLayer removeFromSuperlayer];
    CAGradientLayer *programLayer = [CAGradientLayer layer];
    programLayer.frame = rect;
    programLayer.cornerRadius = self.cornerRadius ? self.cornerRadius : 0;
    programLayer.startPoint = CGPointMake(0, 0.5);
    programLayer.endPoint = CGPointMake(1, 0.5);
    programLayer.colors = [NSArray arrayWithObjects:
                           (id)[UIColor colorWithHexString:@"f16400"].CGColor,
                           (id)[UIColor colorWithHexString:@"f17d00"].CGColor,
                           nil];
    //[self.layer insertSublayer:programLayer atIndex:0];
    [self.layer addSublayer:programLayer];
    self.programLayer = programLayer;

}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //NSLog(@"drawRect~~~~~~~~ %f %f", rect.size.height, rect.size.width);
    [self drawGradientLayer:rect];
}


@end
