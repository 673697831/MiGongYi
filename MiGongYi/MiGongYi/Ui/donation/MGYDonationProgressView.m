//
//  MGYDonationProgressView.m
//  MiGongYi
//
//  Created by megil on 12/2/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDonationProgressView.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"

@interface MGYDonationProgressView ()

@property (nonatomic, weak) UIImageView *backgroundImageView;
@property (nonatomic, weak) UIView *progressView;
@property (nonatomic, weak) UIButton *donateButton;
@property (nonatomic, assign) CGFloat progress;

@end

@implementation MGYDonationProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.layer.masksToBounds = YES;
        UIImageView *backgroundImageView = [UIImageView new];
        //backgroundImageView.layer.mask = [self createMask];
        backgroundImageView.image = [UIImage imageNamed:@"riceDonateBackground"];
        [self addSubview:backgroundImageView];
        self.backgroundImageView = backgroundImageView;
        
        UIView *progressView = [UIView new];
        progressView.backgroundColor = [UIColor colorWithHexString:@"f16400"];
        [self addSubview:progressView];
        self.progressView = progressView;
        
        UIButton *donateButton = [UIButton new];
        [donateButton setImage:[UIImage imageNamed:@"donate_button_normal"] forState:UIControlStateNormal];
        [donateButton setImage:[UIImage imageNamed:@"donate_button_disable"] forState:UIControlStateHighlighted];
        [self addSubview:donateButton];
        self.donateButton = donateButton;
        
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.donateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
    
    }
    return self;
}

- (void)resetProgress:(CGFloat)progress
{
    self.progress = progress;
    [self setNeedsDisplay];
}

- (CALayer *)createMask
{
    CGFloat i = self.progress * 360;
    CGFloat ct = i /180.0 * M_PI - M_PI/2;
    
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    [aPath addArcWithCenter:CGPointMake(width/2, height/2) radius:width/2 startAngle:-M_PI/2 endAngle:ct clockwise:YES];
    [aPath addLineToPoint:CGPointMake(width/2, height/2)];
    [aPath closePath];
    CAShapeLayer* shape = [CAShapeLayer layer];
    shape.path = aPath.CGPath;

    return shape;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.layer.cornerRadius = self.bounds.size.width/2;
    self.progressView.layer.mask = [self createMask];
}


@end
