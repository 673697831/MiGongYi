//
//  MiChatProgressView.m
//  MiGongYi
//
//  Created by megil on 10/8/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiChatProgressView.h"
#import "UIColor+Expanded.h"
#import "Masonry.h"

@interface MGYMiChatProgressView ()

@property(nonatomic, weak) UIView *backgroundView;
@property(nonatomic, weak) UIView *progressView;
@property(nonatomic, weak) UIImageView *backgroundImageView;
@property(nonatomic, weak) UIImageView *progressImageView;
@property(nonatomic, assign) CGFloat progress;

@end

@implementation MGYMiChatProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.progress = 0;
        UIView *backgroundView = [UIView new];
        backgroundView.layer.cornerRadius = 10;
        backgroundView.layer.backgroundColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        [self addSubview:backgroundView];
        self.backgroundView = backgroundView;
        
        UIView *progressView = [UIView new];
        progressView.layer.cornerRadius = 10;
        progressView.layer.backgroundColor = [UIColor colorWithHexString:@"fd9025"].CGColor;
        [self addSubview:progressView];
        self.progressView = progressView;
        
        UIImageView *backgroundImageView = [UIImageView new];
        [self addSubview:backgroundImageView];
        self.backgroundImageView = backgroundImageView;
        
        UIImageView *progressImageView = [UIImageView new];
        [self addSubview:progressImageView];
        self.progressImageView = progressImageView;
         
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [progressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        progressImageView.layer.mask = [self createMask];
        progressView.layer.mask = [self createMask];
    }
    
    return self;
}

- (CALayer *)createMask
{
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:CGPointMake(0, 0)];
    [aPath addLineToPoint:CGPointMake(width * self.progress, 0.0)];
    [aPath addLineToPoint:CGPointMake(width * self.progress, height)];
    [aPath addLineToPoint:CGPointMake(0, height)];
    [aPath closePath];
    CAShapeLayer* shape = [CAShapeLayer layer];
    shape.path = aPath.CGPath;
    return shape;
}

- (void)resetProgress:(CGFloat)progress
                 type:(MGYMiChatProgressViewType)type
{
    [self layoutIfNeeded];
    self.progress = progress;
    [self.backgroundImageView setImage:[UIImage imageNamed:[self imageNameByType:type][0]]];
    [self.progressImageView setImage:[UIImage imageNamed:[self imageNameByType:type][1]]];
    self.progressImageView.layer.mask = [self createMask];
    self.progressView.layer.mask = [self createMask];
}

- (void)clearImage
{
    [self.backgroundImageView setImage:nil];
    [self.progressImageView setImage:nil];
}

#pragma mark - 样式表
- (NSArray *)imageNameByType:(MGYMiChatProgressViewType)type
{
    NSArray *array = @[@[@"michatlittlemonster1-gray", @"michatlittlemonster1"],
                       @[@"michatlittlemonster2-gray", @"michatlittlemonster2"],
                       @[@"michatlittlemonster3-gray", @"michatlittlemonster3"],
                       @[@"michatlittlemonster4-gray", @"michatlittlemonster4"],
                       @[@"michatlittlemonster5-gray", @"michatlittlemonster5"],
                       @[@"michatlittlemonster6-gray", @"michatlittlemonster6"],
                       ];
    return array[type];
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
