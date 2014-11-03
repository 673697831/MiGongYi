//
//  MGYRiceMoveProgressSubView.m
//  MiGongYi
//
//  Created by megil on 11/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveProgressSubView.h"
#import "Masonry.h"

@interface MGYRiceMoveProgressSubView ()

@property (nonatomic, weak) UIView *backgroundView;
@property (nonatomic, weak) UIView *progressView;

@end

@implementation MGYRiceMoveProgressSubView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithProgress:(CGFloat)progress
{
    self = [self init];
    if (self) {
        UIView *backgroundView = [UIView new];
        [self addSubview:backgroundView];
        self.backgroundView = backgroundView;
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0.42;
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self drawProgressView:progress];
    }
    return self;
}

- (void)drawProgressView:(CGFloat)progress
{
    if (self.progressView) {
        [self.progressView removeFromSuperview];
        self.progressView = nil;
    }
    UIView *progressView = [UIView new];
    progressView.backgroundColor = [UIColor orangeColor];
    [self addSubview:progressView];
    self.progressView = progressView;
    
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.equalTo(self).with.multipliedBy(progress);
        make.bottom.equalTo(self);
        make.left.equalTo(self);
    }];
}

- (void)resetProgress:(CGFloat)progress
{
    [self drawProgressView:progress];
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
