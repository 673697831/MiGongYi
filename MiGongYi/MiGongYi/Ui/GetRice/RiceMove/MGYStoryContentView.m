//
//  MGYStoryContentView.m
//  MiGongYi
//
//  Created by megil on 11/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYStoryContentView.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"

@interface MGYStoryContentView ()

@property (nonatomic, weak) UIView *borderView;
@property (nonatomic, weak) UIButton *clickButton;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIImageView *littleManImageView;

@end

@implementation MGYStoryContentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIView *borderView = [UIView new];
        borderView.backgroundColor = [UIColor whiteColor];
        borderView.layer.borderColor = [UIColor colorWithHexString:@"a2dcf4"].CGColor;
        borderView.layer.borderWidth = 5;
        [self addSubview:borderView];
        
        UILabel *contentLabel = [UILabel new];
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.font = [UIFont systemFontOfSize:12];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UIButton *clickButton = [UIButton new];
        [clickButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clickButton];
        self.clickButton = clickButton;
        
        UIImageView *littleManImageView = [UIImageView new];
        [littleManImageView setImage:[UIImage imageNamed:@"littleman1"]];
        [self addSubview:littleManImageView];
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(512/2);
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        
        [clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentLabel).with.offset(-50);
            make.left.equalTo(contentLabel).with.offset(-5);
            make.right.equalTo(contentLabel).with.offset(5);
            make.bottom.equalTo(contentLabel).with.offset(5);
        }];
        
        [littleManImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(contentLabel.mas_top);
        }];
    }
    return self;
}

- (void)click:(id)sender
{
    self.hidden = YES;
}

- (void)resetContent:(NSString *)content
{
    self.contentLabel.text = content;
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
