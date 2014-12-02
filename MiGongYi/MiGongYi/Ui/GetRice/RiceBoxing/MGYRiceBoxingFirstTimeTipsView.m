//
//  MGYRiceBoxingFirstTimeTipsView.m
//  MiGongYi
//
//  Created by megil on 12/2/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceBoxingFirstTimeTipsView.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"

@interface MGYRiceBoxingFirstTimeTipsView ()

@property (nonatomic, weak) UIButton *closeButton;
@property (nonatomic, weak) UIView *borderView;
@property (nonatomic, weak) UIImageView *monsterImageView;
@property (nonatomic, weak) UILabel *monsterNameLabel;
@property (nonatomic, weak) UILabel *familyNameLabel;
@property (nonatomic, weak) UILabel *storyContentLabel;
@property (nonatomic, weak) UILabel *skillContentLabel;
@property (nonatomic ,weak) UILabel *conditionLabel;
@property (nonatomic, weak) CustomIOS7AlertView *alertView;

@end

@implementation MGYRiceBoxingFirstTimeTipsView

- (instancetype)initWithMonster:(MGYMonster *)monster
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self = [super initWithFrame:CGRectMake(0, 0, width, height)];
    if (self) {
        
        UIView *borderView = [UIView new];
        borderView.layer.borderColor = [UIColor colorWithHexString:@"a2dcf4"].CGColor;
        borderView.layer.borderWidth = 5;
        borderView.backgroundColor = [UIColor whiteColor];
        [self addSubview:borderView];
        self.borderView = borderView;
        
        UILabel *storyContentLabel = [UILabel new];
        storyContentLabel.numberOfLines = 0;
        storyContentLabel.font = [UIFont systemFontOfSize:14];
        storyContentLabel.textColor = [UIColor colorWithHexString:@"666666"];
        storyContentLabel.text = monster.storyContent;
        [self addSubview:storyContentLabel];
        self.storyContentLabel = storyContentLabel;
        
        UILabel *skillContentLabel = [UILabel new];
        skillContentLabel.numberOfLines = 0;
        skillContentLabel.font = [UIFont systemFontOfSize:14];
        skillContentLabel.textColor = [UIColor greenColor];
        if (monster.skillContent && ![monster.skillContent isEqualToString:@""]) {
            skillContentLabel.text = [NSString stringWithFormat:@"跟随技能:%@", monster.skillContent];
        }
        [self addSubview:skillContentLabel];
        self.skillContentLabel = skillContentLabel;
        
        UILabel *conditionLabel = [UILabel new];
        conditionLabel.numberOfLines = 0;
        conditionLabel.font = [UIFont systemFontOfSize:14];
        conditionLabel.textColor = [UIColor redColor];
        if (monster.condition && ![monster.condition isEqualToString:@""]) {
            conditionLabel.text = [NSString stringWithFormat:@"特殊:%@", monster.condition];
        }
        [self addSubview:conditionLabel];
        self.conditionLabel = conditionLabel;
        
        UILabel *familyNameLabel = [UILabel new];
        familyNameLabel.font = [UIFont systemFontOfSize:14];
        familyNameLabel.textColor = [UIColor colorWithHexString:@"bababa"];
        familyNameLabel.text = monster.familyName;
        [self addSubview:familyNameLabel];
        self.familyNameLabel = familyNameLabel;
        
        UILabel *monsterNameLabel = [UILabel new];
        monsterNameLabel.font = [UIFont systemFontOfSize:15];
        monsterNameLabel.textColor = [UIColor colorWithHexString:@"f16400"];
        monsterNameLabel.text = monster.monsterName;
        [self addSubview:monsterNameLabel];
        self.monsterNameLabel = monsterNameLabel;
        
        UIImageView *monsterImageView = [UIImageView new];
        monsterImageView.image = [UIImage imageNamed:monster.normalImagePath];
        monsterImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:monsterImageView];
        self.monsterImageView = monsterImageView;
        
        UIButton *closeButton = [UIButton new];
        [closeButton addTarget:self
                        action:@selector(closeSelf)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        self.closeButton = closeButton;
        
        [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.storyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(516/2);
            make.top.equalTo(self.mas_centerY);
        }];
        
        [self.skillContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.storyContentLabel);
            make.width.equalTo(self.storyContentLabel);
            make.top.equalTo(self.storyContentLabel.mas_bottom);
        }];
        
        [self.conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.skillContentLabel);
            make.width.equalTo(self.skillContentLabel);
            make.top.equalTo(self.skillContentLabel.mas_bottom);
        }];
        
        [self.familyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.storyContentLabel.mas_top).with.offset(-18);
            make.centerX.equalTo(self);
        }];
        
        [self.monsterNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.familyNameLabel.mas_top).with.offset(-9);
        }];
        
        [self.monsterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(125);
            make.height.mas_equalTo(125);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.monsterNameLabel.mas_top).with.offset(-18);
        }];
        
        [self.borderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.monsterImageView.mas_centerY);
            make.left.equalTo(self.storyContentLabel).with.offset(-10);
            make.right.equalTo(self.storyContentLabel).with.offset(10);
            make.bottom.equalTo(self.conditionLabel).with.offset(10);
        }];
        
        self.backgroundColor = [UIColor clearColor];
        
        [self show];
    }
    return self;
}

- (void)closeSelf
{
    [self.alertView close:nil];
}

- (void)close
{
    [self.alertView close:nil];
}

- (void)show
{
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    alertView.useIOS7style = NO;
    [alertView addSubview:self];
    [alertView setButtonTitles:NULL];
    
    // Add some custom content to the alert view
    [alertView setContainerView:self];
    [alertView setUseMotionEffects:true];
    
    self.alertView = alertView;
    
    // And launch the dialog
    [alertView show];
    
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
