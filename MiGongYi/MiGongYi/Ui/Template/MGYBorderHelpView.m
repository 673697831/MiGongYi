//
//  MGYBorderHelpView.m
//  MiGongYi
//
//  Created by megil on 11/18/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYBorderHelpView.h"
#import "UIColor+Expanded.h"
#import "Masonry.h"

@interface MGYBorderHelpView ()

@property (nonatomic, weak) UIView *borderView;
@property (nonatomic, weak) UIButton *clickButton;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIImageView *littleManImageView;
@property (nonatomic, weak) UIButton *confirmButton;

@end

@implementation MGYBorderHelpView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *borderView = [UIView new];
        borderView.backgroundColor = [UIColor whiteColor];
        borderView.layer.borderColor = [UIColor colorWithHexString:@"a2dcf4"].CGColor;
        borderView.layer.borderWidth = 5;
        [self addSubview:borderView];
        
        UIButton *confirmButton = [UIButton new];
        [confirmButton setTitle:@"确认"
                       forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor whiteColor]
                            forState:UIControlStateNormal];
        confirmButton.backgroundColor = [UIColor colorWithHexString:@"a2dcf4"];
        [self addSubview:confirmButton];
        
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
            make.bottom.equalTo(contentLabel).with.offset(50);
        }];
        
        [littleManImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(contentLabel.mas_top);
        }];
        
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(contentLabel.mas_bottom);
            make.width.mas_equalTo(270/2);
            make.height.mas_equalTo(30);
        }];

    }
    return self;
}

- (instancetype)initRiceMoveHelpView
{
    self = [self init];
    if (self) {
        self.contentLabel.text = [self riceMoveContent];
    }
    return self;
}

- (instancetype)initRiceBoxingHelpView
{
    self = [self init];
    if(self){
        
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

- (NSString *)riceBoxingContent
{
    return @"米拳击：握紧手机挥拳即可攻击小怪并造成伤害，打败小怪即可获得大米。当然咯，总是欺负小喽喽会把老大激怒的，累计打死3次小怪和2次中怪，就可以获得额外一次挑战boss的机会，在特定的条件下打败boss还能获得巨额的大米奖励并点亮拳套上的荣誉星星哦！不仅如此，累计打败同一只小怪达到一定次数，就可以将它驯服，在图鉴页面点击跟随即可出现在人物身边，偷偷告诉您，不同的小怪还会带给您不同的能力加成呢，加油打怪吧！";
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
