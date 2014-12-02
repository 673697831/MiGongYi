//
//  MGYDonationTableViewCell.m
//  MiGongYi
//
//  Created by megil on 12/2/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDonationTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"

@interface MGYDonationTableViewCell ()

@property (nonatomic, weak) UILabel *levelLabel;
@property (nonatomic, weak) UILabel *riceDonateLabel;
@property (nonatomic, weak) UILabel *itemCountLabel;
@property (nonatomic, weak) UILabel *itemRiceDonateLabel;
@property (nonatomic, weak) UILabel *liLabel;
@property (nonatomic, weak) UILabel *deLabel;
@property (nonatomic, weak) UIButton *shareButton;
@property (nonatomic, weak) MGYDonationProgressView *progressView;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MGYDonationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UILabel *levelLabel = [UILabel new];
        levelLabel.font = [UIFont systemFontOfSize:22/2];
        levelLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        levelLabel.text = @"LV:18";
        [self addSubview:levelLabel];
        self.levelLabel = levelLabel;
        
        UILabel *riceDonateLabel = [UILabel new];
        riceDonateLabel.font = [UIFont systemFontOfSize:9];
        riceDonateLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        riceDonateLabel.text = @"捐赠总米数:87878";
        [self addSubview:riceDonateLabel];
        self.riceDonateLabel = riceDonateLabel;
        
        UILabel *itemCountLabel = [UILabel new];
        itemCountLabel.font = [UIFont systemFontOfSize:9];
        itemCountLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        itemCountLabel.text = @"捐赠项目数:8";
        [self addSubview:itemCountLabel];
        self.itemCountLabel = itemCountLabel;
        
        UILabel *itemRiceDonateLabel = [UILabel new];
        itemRiceDonateLabel.font = [UIFont systemFontOfSize:24];
        itemRiceDonateLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        itemRiceDonateLabel.text = @"987";
        [self addSubview:itemRiceDonateLabel];
        self.itemRiceDonateLabel = itemRiceDonateLabel;
        
        UILabel *liLabel = [UILabel new];
        liLabel.font = [UIFont systemFontOfSize:8];
        liLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        liLabel.text = @"粒";
        [self addSubview:liLabel];
        self.liLabel = liLabel;
        
        UILabel *deLabel = [UILabel new];
        deLabel.font = [UIFont systemFontOfSize:8];
        deLabel.textColor = [UIColor colorWithHexString:@"676767"];
        deLabel.text = @"本项目贡献";
        [self addSubview:deLabel];
        self.deLabel = deLabel;
        
        MGYDonationProgressView *progressView = [MGYDonationProgressView new];
        [self addSubview:progressView];
        self.progressView = progressView;
        
        // Do any additional setup after loading the view.
        
        [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(36/2);
            make.top.equalTo(self.mas_top).with.offset(20);
        }];
        
        [self.riceDonateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.levelLabel.mas_right).with.offset(20);
            make.top.equalTo(self.levelLabel);
        }];
        
        [self.itemCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.riceDonateLabel.mas_right).with.offset(20);
            make.top.equalTo(self.riceDonateLabel);
        }];
        
        [self.itemRiceDonateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.levelLabel);
            make.top.equalTo(self.levelLabel.mas_bottom).with.offset(20);
        }];
        
        [self.liLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.itemRiceDonateLabel.mas_right);
            make.bottom.equalTo(self.itemRiceDonateLabel).with.offset(-5);
        }];
        
        [self.deLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.levelLabel);
            make.top.equalTo(self.itemRiceDonateLabel.mas_bottom).with.offset(7);
        }];
        
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(282/2);
            make.height.mas_equalTo(282/2);
            make.centerX.equalTo(self);
            make.top.equalTo(self.itemCountLabel.mas_bottom).with.offset(20);
        }];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)resetProgress:(CGFloat)progress
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerProgress) userInfo:nil repeats:YES];
    self.progress = 0;
}

- (void)timerProgress
{
    [self.progressView resetProgress:self.progress];
    self.progress = self.progress + 0.05;
    if(self.progress > 1.01){
        [self.timer invalidate];
        self.timer = nil;
        
    }

}

@end
