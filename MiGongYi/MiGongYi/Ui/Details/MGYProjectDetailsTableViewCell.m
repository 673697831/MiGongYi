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
@property(nonatomic, weak) UILabel *helpNumLabel;
@property(nonatomic, weak) UILabel *lineLabel3;
@property(nonatomic, weak) UILabel *updateLabel;

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
    
    [self.helpNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(110/2);
        make.top.equalTo(self.lineLabel2.mas_bottom);
        make.centerX.equalTo(self);
    }];
    
    [self.lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(552/2);
        make.height.mas_equalTo(1);
        make.centerX.equalTo(self);
        make.top.equalTo(self.helpNumLabel.mas_bottom);
    }];
    
    [self.updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.lineLabel3.mas_bottom);
        make.height.mas_equalTo(40);
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
        
        UILabel *helpNumLabel = [UILabel new];
        //helpNumLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:helpNumLabel];
        self.helpNumLabel = helpNumLabel;
        
        self.lineLabel3 = [self lineLabelFactory];
        [self addSubview:self.lineLabel3];
        
        UILabel *updateLabel = [UILabel new];
        updateLabel.text = @"近况更新";
        updateLabel.font = [UIFont systemFontOfSize:14];
        updateLabel.textColor = [UIColor colorWithHexString:@"838383"];
        [self addSubview:updateLabel];
        self.updateLabel = updateLabel;
        
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
    
    [self.progressView updateProgress:details.progress];
    
    NSString *st1 = @"目前为止已经有";
    NSString *st2 = [NSString stringWithFormat:@"%d", details.helpMemberNum];
    NSString *st3 = @"帮助过我";
    //NSLog(@"%d %d %d", st1.length, st2.length, st3.length);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@", st1, st2, st3]];
    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor colorWithHexString:@"838383"]
                range:NSMakeRange(0, st1.length)];
    [str addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:14]
                range:NSMakeRange(0, st1.length)];
    
    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor colorWithHexString:@"f16400"]
                range:NSMakeRange(st1.length, st2.length)];
    [str addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:24]
                range:NSMakeRange(st1.length, st2.length)];
    
    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor colorWithHexString:@"838383"]
                range:NSMakeRange(st1.length + st2.length, st3.length)];
    [str addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:14]
                range:NSMakeRange(st1.length + st2.length, st3.length)];
    
    self.helpNumLabel.attributedText = str;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
