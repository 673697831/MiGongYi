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
        make.top.equalTo(self.mas_top).with.offset(10);
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
    
    UILabel *itemlabel1 = [UILabel new];
    [self addSubview:itemlabel1];
    itemlabel1.text = @"捐赠方";
    [self setFont:itemlabel1];
    self.itemlabel1 = itemlabel1;
    
    UIImageView *donorImageView = [UIImageView new];
    [self addSubview:donorImageView];
    self.donorImageView = donorImageView;
    
    UILabel *itemTitleLabel1 = [UILabel new];
    [self addSubview:itemTitleLabel1];
    [self setFont:itemTitleLabel1];
    self.itemTitleLabel1 = itemTitleLabel1;
    
    [self setup];
}

- (void)setFont:(UILabel *) label
{
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor colorWithHexString:@"676767"];
}

- (void)update:(MGYProjectDetails *)details
{
    [self.donorImageView sd_setImageWithURL:[NSURL URLWithString:details.donor[@"show_img"]]];
    self.itemTitleLabel1.text = details.donor[@"title"];
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
