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

@property(nonatomic, weak) UILabel *lineLabel;

@property(nonatomic, weak) UILabel *blockLabel1;
@property(nonatomic, weak) UILabel *itemlabel1;
@property(nonatomic, weak) UIImageView *donorImageView;
@property(nonatomic, weak) UILabel *itemTitleLabel1;

@property(nonatomic, weak) UILabel *blockLabel2;
@property(nonatomic, weak) UILabel *itemlabel2;
@property(nonatomic, weak) UIImageView *recipientImageView;
@property(nonatomic, weak) UILabel *itemTitleLabel2;

@property(nonatomic, weak) UILabel *blockLabel3;
@property(nonatomic, weak) UILabel *itemlabel3;
@property(nonatomic, weak) UILabel *numLabel;
@property(nonatomic, weak) UILabel *itemTitleLabel3;

@property(nonatomic, weak) UILabel *lineLabel2;

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
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(552/2);
        make.top.equalTo(self);
        make.left.equalTo(self);
    }];
    
    [self.blockLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(2);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.lineLabel.mas_bottom).with.offset(10);
    }];
    
    [self.itemlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blockLabel1.mas_right).with.offset(5);
        make.top.equalTo(self.blockLabel1.mas_top);
    }];
    
    [self.donorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
        make.top.equalTo(self.blockLabel1);
        make.left.equalTo(self.blockLabel1.mas_left).with.offset(168/2);
    }];
    
    [self.itemTitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blockLabel1);
        make.centerX.equalTo(self.donorImageView.mas_right).with.offset(168/2);
    }];
    
    [self.blockLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(2);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.blockLabel1.mas_bottom).with.offset(10);
    }];
    
    [self.itemlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blockLabel2.mas_right).with.offset(5);
        make.top.equalTo(self.blockLabel2.mas_top);
    }];
    
    [self.recipientImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
        make.top.equalTo(self.blockLabel2);
        make.left.equalTo(self.blockLabel2.mas_left).with.offset(168/2);
    }];
    
    [self.itemTitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blockLabel2);
        make.centerX.equalTo(self.recipientImageView.mas_right).with.offset(168/2);
    }];
    
    [self.blockLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(2);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.blockLabel2.mas_bottom).with.offset(10);
    }];
    
    [self.itemlabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blockLabel3.mas_right).with.offset(5);
        make.top.equalTo(self.blockLabel3.mas_top);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blockLabel3);
        make.centerX.equalTo(self.recipientImageView.mas_centerX);
    }];
    
    [self.itemTitleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blockLabel3);
        make.centerX.equalTo(self.numLabel.mas_right).with.offset(168/2);
    }];
    
    [self.lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(552/2);
        make.top.equalTo(self.lineLabel.mas_bottom).with.offset(100);
        make.left.equalTo(self);
    }];
}

- (void)drawCell
{
    UILabel *lineLabel = [UILabel new];
    [self addSubview:lineLabel];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    self.lineLabel = lineLabel;
    
    UILabel *blockLabel1 = [UILabel new];
    [self addSubview:blockLabel1];
    blockLabel1.backgroundColor = [UIColor colorWithHexString:@"f16400"];
    self.blockLabel1 = blockLabel1;
    
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
    
    UILabel *blockLabel2 = [UILabel new];
    [self addSubview:blockLabel2];
    blockLabel2.backgroundColor = [UIColor colorWithHexString:@"a2dcf4"];
    self.blockLabel2 = blockLabel2;
    
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
    
    UILabel *blockLabel3 = [UILabel new];
    [self addSubview:blockLabel3];
    blockLabel3.backgroundColor = [UIColor colorWithHexString:@"676767"];
    self.blockLabel3 = blockLabel3;
    
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
    
    UILabel *lineLabel2 = [UILabel new];
    [self addSubview:lineLabel2];
    lineLabel2.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    self.lineLabel2 = lineLabel2;
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
    [self.donorImageView sd_setImageWithURL:[NSURL URLWithString:details.donor[@"show_img"]]];
    self.itemTitleLabel1.text = details.donor[@"title"];
    [self.recipientImageView sd_setImageWithURL:[NSURL URLWithString:details.recipient[@"show_img"]]];
    self.itemTitleLabel2.text = details.recipient[@"title"];
    self.numLabel.text = [NSString stringWithFormat:@"%d",[details.resource[@"resource_num"] integerValue]];
    self.itemTitleLabel3.text = details.resource[@"resource_name"];
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
