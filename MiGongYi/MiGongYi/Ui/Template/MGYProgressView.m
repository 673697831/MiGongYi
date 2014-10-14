//
//  MGYProgressView.m
//  MiGongYi
//
//  Created by megil on 9/12/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYProgressView.h"
#import "UIColor+Expanded.h"

@interface MGYProgressView ()
@property(nonatomic, assign) NSInteger progress;
@end

@implementation MGYProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.progress = 0;
    }
    return self;
}

- (void)resetProgress:(NSInteger)percent
{
    self.progress = percent;
    [self layoutIfNeeded];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawCAlayer:(CGRect)rect
{
    if (!self.progress) {
        self.progress = 0;
    }
    
    CALayer *backgroundLayer = [CALayer layer];
    backgroundLayer.backgroundColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
    backgroundLayer.frame = rect;
    backgroundLayer.cornerRadius = rect.size.height/2;
    self.backgroundColor = [UIColor clearColor];
    [self.layer addSublayer:backgroundLayer];
}

- (void)drawMask
{
    CGFloat r = self.progress > 0 ? self.frame.size.height/2 : 0;
    CGFloat value = self.progress / 100.0 * self.frame.size.width - r;
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    if (value <=  r) {
        // 画整个圆
        value = value + r;
        
//        [aPath addArcWithCenter:CGPointMake(value, r) radius: value startAngle:-M_PI/2 endAngle:M_PI/2 clockwise:YES];
//        [aPath addArcWithCenter:CGPointMake(value, r) radius: value startAngle:M_PI/2 endAngle:-M_PI/2 clockwise:YES];
        CGFloat tmp = sqrt(2*r*value - value*value) / r ;
        double CT = acos(tmp);
        [aPath addArcWithCenter:CGPointMake(r, r) radius: r startAngle:M_PI/2+CT endAngle:-M_PI/2-CT clockwise:YES];
    }
    else
    {
        [aPath moveToPoint:CGPointMake(r, 0)];
        [aPath addLineToPoint:CGPointMake(value, 0.0)];
        [aPath addArcWithCenter:CGPointMake(value, r) radius:r startAngle:-M_PI/2 endAngle:M_PI/2 clockwise:YES];
        [aPath addLineToPoint:CGPointMake(r, 2*r)];
        [aPath addArcWithCenter:CGPointMake(r, r) radius:r startAngle:M_PI/2 endAngle:-M_PI/2 clockwise:YES];
    }
    [aPath closePath];
    CAShapeLayer* shape = [CAShapeLayer layer];
    shape.path = aPath.CGPath;
    self.programLayer.mask = shape;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [self drawCAlayer:rect];
    [self drawGradientLayer:rect];
    [self drawMask];
    
}


@end
