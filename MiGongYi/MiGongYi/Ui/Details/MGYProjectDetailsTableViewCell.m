//
//  MGYProjectDetailsTableViewCell.m
//  MiGongYi
//
//  Created by megil on 9/22/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYProjectDetailsTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Expanded.h"
#import "MGYDetailsRelationshipView.h"
#import "MGYProgressView.h"
#import "MGYDetailsIconListView.h"

@interface MGYProjectDetailsTableViewCell ()

@property(nonatomic, weak) UIImageView *detailsImageView;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) MGYDetailsRelationshipView *relationshipView;
@property(nonatomic, weak) UILabel *summaryLabel;
@property(nonatomic, weak) UIButton *readmoreButton;
@property(nonatomic, weak) UILabel *linelabel1;
@property(nonatomic, weak) MGYProgressView *progressView;
@property(nonatomic, weak) MGYDetailsIconListView *iconListView;
@property(nonatomic, weak) UILabel *lineLabel2;

@end

@implementation MGYProjectDetailsTableViewCell

- (void)setup
{
    [self.detailsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(self.bounds.size.width * 0.7);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailsImageView.mas_bottom).with.offset(20);
        make.centerX.equalTo(self);
    }];
    
    [self.relationshipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(105);
        make.width.mas_equalTo(552/2);
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(15);
    }];
    
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(552/2);
        make.centerX.equalTo(self);
        make.top.equalTo(self.relationshipView.mas_bottom).with.offset(10);
    }];
    
    [self.readmoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(35);
        make.centerX.equalTo(self);
        make.top.equalTo(self.summaryLabel.mas_bottom).with.offset(15);
    }];
    
    [self.linelabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(552/2);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.readmoreButton.mas_bottom).with.offset(15);
        make.centerX.equalTo(self);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(552/2);
        make.top.equalTo(self.linelabel1.mas_bottom).with.offset(10);
        make.centerX.equalTo(self);
    }];
    
//    [self.leftIconView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(104/2);
//        make.width.mas_equalTo(552/3/2);
//        make.top.equalTo(self.progressView.mas_bottom).with.offset(15);
//        make.left.equalTo(self.linelabel1.mas_left);
//    }];
    [self.iconListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(104/2);
        make.width.mas_equalTo(552/2);
        make.centerX.equalTo(self);
        make.top.equalTo(self.progressView.mas_bottom).with.offset(15);
    }];
    
    [self.lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(552/2);
        make.height.mas_equalTo(1);
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconListView.mas_bottom).with.offset(20);
    }];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *detailsImageView = [UIImageView new];
        [self addSubview:detailsImageView];
        self.detailsImageView = detailsImageView;
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = [UIColor colorWithHexString:@"676767"];
        titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        MGYDetailsRelationshipView *relationshipView = [MGYDetailsRelationshipView new];
        [self addSubview:relationshipView];
        self.relationshipView = relationshipView;
        
        UILabel *summaryLabel = [UILabel new];
        summaryLabel.numberOfLines = 0;
        //summaryLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        summaryLabel.font = [UIFont systemFontOfSize:13];
        summaryLabel.textColor = [UIColor colorWithHexString:@"838383"];
        [self addSubview:summaryLabel];
        self.summaryLabel = summaryLabel;
        
        UIButton *readmoreButton = [UIButton new];
        [self addSubview:readmoreButton];
        readmoreButton.layer.borderWidth = 1;
        readmoreButton.layer.borderColor = [UIColor colorWithHexString:@"f16400"].CGColor;
        [readmoreButton setTitle:@"阅读更多"
                        forState:UIControlStateNormal];
        readmoreButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [readmoreButton setTitleColor:[UIColor colorWithHexString:@"f16400"]
                             forState:UIControlStateNormal];
        self.readmoreButton = readmoreButton;
        
        self.linelabel1 = [self lineLabelFactory];
        [self addSubview:self.linelabel1];
        
        //MGYProgressView *progressView = [[MGYProgressView alloc] initWithFrame:CGRectMake(0, 0, 552/2, 10)];
        MGYProgressView *progressView = [MGYProgressView new];
        [self addSubview:progressView];
        progressView.backgroundColor = [UIColor clearColor];
        self.progressView = progressView;
        
//        MGYDetailsIcon *leftIconView = [[MGYDetailsIcon alloc] initWithFrame:CGRectMake(0, 0, 552/3/2, 104/2)];
//        [leftIconView resetDetails:@"355580"
//                                 path:@"page_Rice_normal2"
//                                 text:@"捐赠米粒"];
//        [self addSubview:leftIconView];
//        self.leftIconView = leftIconView;
        MGYDetailsIconListView *iconListView = [[MGYDetailsIconListView alloc] initWithFrame:CGRectMake(0, 0, 552/2, 104/2)];
        [self addSubview:iconListView];
        self.iconListView = iconListView;
        
        self.lineLabel2 = [self lineLabelFactory];
        [self addSubview:self.lineLabel2];
        
        
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UILabel *)lineLabelFactory
{
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    return label;
}

- (void)update:(MGYProjectDetails *)details
{
    [self.detailsImageView sd_setImageWithURL:[NSURL URLWithString:details.detailImg]];
    self.titleLabel.text = details.title;
    [self.relationshipView update:details];
    CGSize labelSize = [details.summary boundingRectWithSize:CGSizeMake(512/2, 5000) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size;
    self.summaryLabel.text = details.summary;
    
    self.summaryLabel.frame = CGRectMake(self.summaryLabel.frame.origin.x, self.summaryLabel.frame.origin.y, self.summaryLabel.frame.size.width, labelSize.height);//保持原来Label的位置和宽度，只是改变高度。
    [self.iconListView update:details.riceDonate joinNum:details.joinMemberNum favNum:details.favNum];

    NSLog(@"iiiiiii %f %f", labelSize.height, labelSize.width);
}

- (CGFloat)getCellHeight
{
    CGFloat height = 0;
    height = height + self.detailsImageView.bounds.size.height;
    height = height + self.titleLabel.bounds.size.height;
    height = height + 20;
    height = height + self.relationshipView.bounds.size.height;
    height = height + 15;
    height = height + self.summaryLabel.bounds.size.height;
    height = height + 10;
    height = height + self.readmoreButton.bounds.size.height;
    height = height + 15;
    
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
