//
//  MGYHelpView.m
//  MiGongYi
//
//  Created by megil on 11/18/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYHelpView.h"
#import "UIColor+Expanded.h"
#import "Masonry.h"

@interface MGYHelpView ()

@property (nonatomic, weak) UIButton *hideButton;
@property (nonatomic, weak) UIImageView *closeImageView;
@property (nonatomic, weak) UIImageView *littleManImageView;
@property (nonatomic, weak) UILabel *helpContent;

@end

@implementation MGYHelpView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIButton *hideButton = [UIButton new];
        hideButton.backgroundColor = [UIColor blackColor];
        [hideButton addTarget:self
                       action:@selector(click:)
             forControlEvents:UIControlEventTouchUpInside];
        hideButton.alpha = 0.8;
        [self addSubview:hideButton];
        self.hideButton = hideButton;
        
        UIImageView *closeImageView = [UIImageView new];
        [closeImageView setImage:[UIImage imageNamed:@"close_button"]];
        [self addSubview:closeImageView];
        self.closeImageView = closeImageView;
        
        UIImageView *littleManImageView = [UIImageView new];
        [littleManImageView setImage:[UIImage imageNamed:@"littleman1"]];
        [self addSubview:littleManImageView];
        self.littleManImageView = littleManImageView;
        
        UILabel *helpContent = [UILabel new];
        helpContent.textColor = [UIColor whiteColor];
        helpContent.font = [UIFont systemFontOfSize:12];
        helpContent.numberOfLines = 0;
        self.helpContent = helpContent;
        [self addSubview:helpContent];
        
        [self.helpContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(32);
            make.right.equalTo(self).with.offset(-32);
            make.centerY.equalTo(self);
        }];

        [self.littleManImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.helpContent.mas_top).with.offset(-16);
        }];
        
        [self.closeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(10);
            make.right.equalTo(self).with.offset(-10);
        }];
        
        [self.hideButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (instancetype)initRiceMoveHelpView
{
    self = [self init];
    if (self) {
        self.helpContent.text = [self riceMoveContent];
    }
    return self;
}

- (void)click:(id)sender
{
    self.hidden = YES;
}

- (NSString *)riceMoveContent
{
    return @"米有氧：米有氧会在后台为您记录行走步数，转化为米动力(无GPS, 免流量, 不费电)。当您拥有米动力的时候，点击“Go”按钮，就可以消耗这些动力来帮助大郎探索剧情，沿着进度条上的剧情点，触发各种神秘事件，而您的选择和坚持，极有可能会带给大郎和这个危在旦夕的世界不同的结局哦！心动不如行动，快去体验吧！";
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
