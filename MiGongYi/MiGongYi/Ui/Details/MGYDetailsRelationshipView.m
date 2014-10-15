//
//  MGYDetailsRelationshipView.m
//  MiGongYi
//
//  Created by megil on 9/22/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDetailsRelationshipView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Expanded.h"

@interface MGYDetailsRelationshipView ()

@property(nonatomic, weak) UIView *lineView;

@property(nonatomic, weak) UIView *blockView1;
@property(nonatomic, weak) UILabel *itemlabel1;
@property(nonatomic, weak) UIImageView *donorImageView;
@property(nonatomic, weak) UILabel *itemTitleLabel1;

@property(nonatomic, weak) UIView *blockView2;
@property(nonatomic, weak) UILabel *itemlabel2;
@property(nonatomic, weak) UIImageView *recipientImageView;
@property(nonatomic, weak) UILabel *itemTitleLabel2;

@property(nonatomic, weak) UIView *blockView3;
@property(nonatomic, weak) UILabel *itemlabel3;
@property(nonatomic, weak) UILabel *numLabel;
@property(nonatomic, weak) UILabel *itemTitleLabel3;

@property(nonatomic, weak) UIView *lineView2;

@end

@implementation MGYDetailsRelationshipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self drawCell];
    }
    return self;
}

- (void)setup
{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.width.mas_equalTo(552/2);
        make.top.equalTo(self);
        make.left.equalTo(self);
    }];
    
    [self.blockView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(2);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.lineView.mas_bottom).with.offset(10);
    }];
    
    [self.itemlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blockView1.mas_right).with.offset(5);
        make.top.equalTo(self.blockView1.mas_top);
    }];
    
    [self.donorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
        make.top.equalTo(self.blockView1);
        make.left.equalTo(self.blockView1.mas_left).with.offset(168/2);
    }];
    
    [self.itemTitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blockView1);
        make.centerX.equalTo(self.donorImageView.mas_right).with.offset(168/2);
    }];
    
    [self.blockView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(2);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.blockView1.mas_bottom).with.offset(10);
    }];
    
    [self.itemlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blockView2.mas_right).with.offset(5);
        make.top.equalTo(self.blockView2.mas_top);
    }];
    
    [self.recipientImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
        make.top.equalTo(self.blockView2);
        make.left.equalTo(self.blockView2.mas_left).with.offset(168/2);
    }];
    
    [self.itemTitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blockView2);
        make.centerX.equalTo(self.recipientImageView.mas_right).with.offset(168/2);
    }];
    
    [self.blockView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(2);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.blockView2.mas_bottom).with.offset(10);
    }];
    
    [self.itemlabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blockView3.mas_right).with.offset(5);
        make.top.equalTo(self.blockView3.mas_top);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blockView3);
        make.centerX.equalTo(self.recipientImageView.mas_centerX);
    }];
    
    [self.itemTitleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blockView3);
        make.centerX.equalTo(self.numLabel.mas_right).with.offset(168/2);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.width.mas_equalTo(552/2);
        make.top.equalTo(self.lineView.mas_bottom).with.offset(100);
        make.left.equalTo(self);
    }];
}

- (void)drawCell
{
    UIView *lineView = [UIView new];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    self.lineView = lineView;
    
    UILabel *blockView1 = [UILabel new];
    [self addSubview:blockView1];
    blockView1.backgroundColor = [UIColor colorWithHexString:@"f16400"];
    self.blockView1 = blockView1;
    
    UILabel *itemlabel1 = [self labelFactory];
    self.itemlabel1 = itemlabel1;
    [self addSubview:self.itemlabel1];
    self.itemlabel1.text = NSLocalizedString(@"捐赠方", @"捐赠方");
    
    UIImageView *donorImageView = [UIImageView new];
    [self addSubview:donorImageView];
    self.donorImageView = donorImageView;
    
    UILabel *itemTitleLabel1 = [self labelFactory];
    self.itemTitleLabel1 = itemTitleLabel1;
    [self addSubview:self.itemTitleLabel1];
    
    UILabel *blockView2 = [UILabel new];
    [self addSubview:blockView2];
    blockView2.backgroundColor = [UIColor colorWithHexString:@"a2dcf4"];
    self.blockView2 = blockView2;
    
    UILabel *itemlabel2 = [self labelFactory];
    self.itemlabel2 = itemlabel2;
    [self addSubview:self.itemlabel2];
    self.itemlabel2.text = NSLocalizedString(@"接受方", @"接受方");
    
    UIImageView *recipientImageView = [UIImageView new];
    [self addSubview:recipientImageView];
    self.recipientImageView = recipientImageView;
    
    UILabel *itemTitleLabel2 = [self labelFactory];
    self.itemTitleLabel2 = itemTitleLabel2;
    [self addSubview:self.itemTitleLabel2];
    
    UILabel *blockView3 = [UILabel new];
    [self addSubview:blockView3];
    blockView3.backgroundColor = [UIColor colorWithHexString:@"676767"];
    self.blockView3 = blockView3;
    
    UILabel *itemlabel3 = [self labelFactory];
    self.itemlabel3 = itemlabel3;
    [self addSubview:self.itemlabel3];
    self.itemlabel3.text = NSLocalizedString(@"捐赠量", @"捐赠量");
    
    UILabel *numLabel = [self labelFactory];
    self.numLabel = numLabel;
    [self addSubview:self.numLabel];
    
    UILabel *itemTitleLabel3 = [self labelFactory];
    self.itemTitleLabel3 = itemTitleLabel3;
    [self addSubview:self.itemTitleLabel3];
    
    UIView *lineView2 = [UIView new];
    [self addSubview:lineView2];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    self.lineView2 = lineView2;
    [self setup];
}

- (UILabel *)labelFactory
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor colorWithHexString:@"676767"];
    return label;
}

- (void)reset:(MGYProjectDetails *)details
{
    //[self.donorImageView sd_setImageWithURL:[NSURL URLWithString:details.donor[@"show_img"]]];
    [self.donorImageView sd_setImageWithURL:[NSURL URLWithString:details.donor.showImg]];
    //self.itemTitleLabel1.text = details.donor[@"title"];
    self.itemTitleLabel1.text = details.donor.title;
    [self.recipientImageView sd_setImageWithURL:[NSURL URLWithString:details.recipient.showImg]];
    self.itemTitleLabel2.text = details.recipient.title;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",(long)details.resource.resourceNum];
    self.itemTitleLabel3.text = details.resource.resourceName;
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
