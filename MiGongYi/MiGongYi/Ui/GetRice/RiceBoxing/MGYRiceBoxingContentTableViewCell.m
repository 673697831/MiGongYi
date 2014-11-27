//
//  MGYRiceBoxingContentTableViewCell.m
//  MiGongYi
//
//  Created by megil on 11/24/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceBoxingContentTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"
#import "DataManager.h"

@interface MGYRiceBoxingContentTableViewCell ()

@property (nonatomic, weak) UIImageView *headImageView;
@property (nonatomic, weak) UIImageView *backgroundImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *dailyImageView;
@property (nonatomic, weak) UIImageView *jiantouImageView;
@property (nonatomic, weak) UILabel *dailyLabel;
@property (nonatomic, weak) UIImageView *monsterImageView;
@property (nonatomic, weak) UILabel *gainRiceLabel;
@property (nonatomic, weak) UILabel *riceNumLabel;
@property (nonatomic, weak) UIButton *continueButton;
@property (nonatomic, weak) UIButton *shareButton;

@end

@implementation MGYRiceBoxingContentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *backgroundImageView = [UIImageView new];
        //backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
        backgroundImageView.image = [UIImage imageNamed:@"rice_boxing_background"];
        [self addSubview:backgroundImageView];
        self.backgroundImageView = backgroundImageView;
        
        UIImageView *dailyImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"rice_boxing_content"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)
                                              resizingMode:UIImageResizingModeStretch];
        
        dailyImageView.image = image;
        [self addSubview:dailyImageView];
        self.dailyImageView = dailyImageView;
        
        UIImageView *jiantouImageView = [UIImageView new];
        jiantouImageView.image = [UIImage imageNamed:@"triangle"];
        [self addSubview:jiantouImageView];
        self.jiantouImageView = jiantouImageView;
        
        UILabel *dailyLabel = [UILabel new];
        dailyLabel.numberOfLines = 0;
        dailyLabel.textColor = [UIColor colorWithHexString:@"676767"];
        dailyLabel.text = @"weoghwoihegowiehgowiehgowiehfwioehfwohgoefiuehfiuheiufehiufheuifheifgiuegfiuegfiuegfiuegiufgeiufgeiufguiegfiuegfuiegfiuegfiuegfiuegfuiegfiuefgeiufgeuifgeiufgeiufgiuegfuiegfiugeiufgeuifgeuigfiuefgiuefgieugfiuegfuiegfiuegfiuegfiuegfiegiufgesdfefeigfuiegfehwfjwepgjpw";
        dailyLabel.font = [UIFont systemFontOfSize:[self.class heightForDailyContent]];
        [self addSubview:dailyLabel];
        self.dailyLabel = dailyLabel;
        
        UIImageView *monsterImageView = [UIImageView new];
        [self addSubview:monsterImageView];
        self.monsterImageView = monsterImageView;
        
        UILabel *gainRiceLabel = [UILabel new];
        gainRiceLabel.text = @"你获得的米数为";
        gainRiceLabel.textColor = [UIColor colorWithHexString:@"c7c7c7"];
        gainRiceLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:gainRiceLabel];
        self.gainRiceLabel = gainRiceLabel;
        
        UILabel *riceNumLabel = [UILabel new];
        riceNumLabel.textColor = [UIColor colorWithHexString:@"f16400"];
        riceNumLabel.font = [UIFont systemFontOfSize:38];
        [self addSubview:riceNumLabel];
        self.riceNumLabel = riceNumLabel;
        
        UIButton *continueButton = [UIButton new];
        continueButton.backgroundColor = [UIColor colorWithHexString:@"a2dcf4"];
        [continueButton setTitleColor:[UIColor whiteColor]
                             forState:UIControlStateNormal];
        [continueButton addTarget:self
                           action:@selector(clickContinue)
                 forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:continueButton];
        self.continueButton = continueButton;
        
        UIButton *shareButton = [UIButton new];
        shareButton.backgroundColor = [UIColor orangeColor];
        [shareButton setTitleColor:[UIColor whiteColor]
                          forState:UIControlStateNormal];
        [shareButton setTitle:@"分享"
                     forState:UIControlStateNormal];
        [self addSubview:shareButton];
        self.shareButton = shareButton;
        
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.width.equalTo(self);
            make.centerX.equalTo(self);
        }];
        
        [self.dailyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset([self.class widthForDailyContent]);
            make.centerX.equalTo(self);
            make.top.equalTo(self.backgroundImageView.mas_bottom).with.offset(56/2);
        }];
        
        [self.dailyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dailyLabel).with.offset(-10);
            make.left.equalTo(self.dailyLabel).with.offset(-10);
            make.bottom.equalTo(self.dailyLabel).with.offset(10);
            make.right.equalTo(self.dailyLabel).with.offset(10);
        }];
        
        [self.jiantouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dailyImageView.mas_bottom);
            make.centerX.equalTo(self);
        }];
        
        [self.monsterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.jiantouImageView.mas_bottom).with.offset(6/2);
        }];
        
        [self.gainRiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.monsterImageView.mas_bottom).with.offset(36/2);
        }];
        
        [self.riceNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.gainRiceLabel.mas_bottom).with.offset(18/2);
        }];
        
        [self.continueButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(270/2);
            make.height.mas_equalTo(60/2);
            make.top.equalTo(self.riceNumLabel.mas_bottom).with.offset(44/2);
        }];
        
        [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(self.continueButton);
            make.height.equalTo(self.continueButton);
            make.top.equalTo(self.continueButton.mas_bottom).with.offset(20);
        }];
        
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)clickContinue
{
    if (self.disappearDelegate) {
        [self.disappearDelegate disappearFromClickButton];
    }
}

- (void)setDetails:(MGYMonster *)monster
         isSuccess:(BOOL)isSuccess
{
    MGYProtocolRiceBoxingObtain *obtain = [DataManager shareInstance].getRiceDataManager.riceBoxingObtain;
    if (monster.monsterType == MGYMonsterTypeLarge) {
        self.dailyLabel.hidden = YES;
        self.dailyImageView.hidden = YES;
        self.jiantouImageView.hidden = YES;
        self.dailyLabel.text = @"";
    }else
    {
        self.dailyLabel.hidden = NO;
        self.dailyImageView.hidden = NO;
        self.jiantouImageView.hidden = NO;
        self.dailyLabel.text = obtain.dailyTips;
    }
    
    self.monsterImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"riceBoxingMonster%d", monster.monsterId]];
    if(isSuccess){
        self.riceNumLabel.text = [NSString stringWithFormat:@"%ld", (long)obtain.rice];
    }else
    {
        self.riceNumLabel.text = @"0";
    }
    [self.continueButton setTitle:[NSString stringWithFormat:@"继续挑战(%ld)", (long)obtain.remainTimes]
                         forState:UIControlStateNormal];
}

+ (CGFloat)minHeight
{
    return (56 + 10 + 10 +6+36+36+18+76+44+60+60+40)/2 + 20 + [UIImage imageNamed:@"rice_boxing_background"].size.height;
}

+ (CGFloat)heightForDailyContent
{
    return 11;
}

+ (CGFloat)widthForDailyContent
{
    return 490/2;
}

@end
