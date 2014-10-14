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

@property(nonatomic, weak) UILabel *backgroundLabel;
@property(nonatomic, weak) UILabel *progressLabel;
@property(nonatomic, weak) UIImageView *backgroundImageView;
@property(nonatomic, weak) UIImageView *progressImageView;
@property(nonatomic, assign) CGFloat progress;
//@property(nonatomic, copy) NSString *backgroundImageName;
//@property(nonatomic, copy) NSString *progressImageName;

@end

@implementation MGYMiChatProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.progress = 0;
        UILabel *backgroundLabel = [UILabel new];
        backgroundLabel.layer.cornerRadius = 10;
        backgroundLabel.layer.backgroundColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        [self addSubview:backgroundLabel];
        self.backgroundLabel = backgroundLabel;
        
        UILabel *progressLabel = [UILabel new];
        progressLabel.layer.cornerRadius = 10;
        progressLabel.layer.backgroundColor = [UIColor colorWithHexString:@"fd9025"].CGColor;
        [self addSubview:progressLabel];
        self.progressLabel = progressLabel;
        
        UIImageView *backgroundImageView = [UIImageView new];
        [self addSubview:backgroundImageView];
        self.backgroundImageView = backgroundImageView;
        
        UIImageView *progressImageView = [UIImageView new];
        [self addSubview:progressImageView];
        self.progressImageView = progressImageView;
         
        [backgroundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [progressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        progressImageView.layer.mask = [self createMask];
        progressLabel.layer.mask = [self createMask];
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
    self.progressLabel.layer.mask = [self createMask];
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
