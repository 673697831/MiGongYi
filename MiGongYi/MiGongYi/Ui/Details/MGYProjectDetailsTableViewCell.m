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

#define OFFSET_Y_1 20
#define VIEW_H_1 17
#define OFFSET_Y_2 15
#define VIEW_H_2 102
#define OFFSET_Y_3 10
#define OFFSET_Y_4 15
#define VIEW_H_3 35
#define OFFSET_Y_5 15
#define OFFSET_Y_6 10
#define VIEW_H_4 10
#define OFFSET_Y_7 15
#define VIEW_H_5 52
#define OFFSET_Y_8 20
#define VIEW_H_6 55
#define VIEW_H_7 40

@interface MGYProjectDetailsTableViewCell ()

@property(nonatomic, weak) UIImageView *detailsImageView;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) MGYDetailsRelationshipView *relationshipView;
@property(nonatomic, weak) UILabel *summaryLabel;
@property(nonatomic, weak) UIButton *readmoreButton;
@property(nonatomic, weak) UIView *lineView1;
@property(nonatomic, weak) MGYProgressView *progressView;
@property(nonatomic, weak) MGYDetailsIconListView *iconListView;
@property(nonatomic, weak) UIView *lineView2;
@property(nonatomic, weak) UILabel *helpNumLabel;
@property(nonatomic, weak) UIView *lineView3;
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
        make.top.equalTo(self.detailsImageView.mas_bottom).with.offset(OFFSET_Y_1);
        make.centerX.equalTo(self);
    }];
    
    [self.relationshipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(VIEW_H_2);
        make.width.mas_equalTo(552/2);
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(OFFSET_Y_2);
    }];
    
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(552/2);
        make.centerX.equalTo(self);
        make.top.equalTo(self.relationshipView.mas_bottom).with.offset(OFFSET_Y_3);
    }];
    
    [self.readmoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(VIEW_H_3);
        make.centerX.equalTo(self);
        make.top.equalTo(self.summaryLabel.mas_bottom).with.offset(OFFSET_Y_4);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(552/2);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.top.equalTo(self.readmoreButton.mas_bottom).with.offset(OFFSET_Y_5);
        make.centerX.equalTo(self);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(VIEW_H_4);
        make.width.mas_equalTo(552/2);
        make.top.equalTo(self.lineView1.mas_bottom).with.offset(OFFSET_Y_6);
        make.centerX.equalTo(self);
    }];
    
    [self.iconListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(VIEW_H_5);
        make.width.mas_equalTo(552/2);
        make.centerX.equalTo(self);
        make.top.equalTo(self.progressView.mas_bottom).with.offset(OFFSET_Y_7);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(552/2);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconListView.mas_bottom).with.offset(OFFSET_Y_8);
    }];
    
    [self.helpNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(VIEW_H_6);
        make.top.equalTo(self.lineView2.mas_bottom);
        make.centerX.equalTo(self);
    }];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(552/2);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.centerX.equalTo(self);
        make.top.equalTo(self.helpNumLabel.mas_bottom);
    }];
    
    [self.updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.lineView3.mas_bottom);
        make.height.mas_equalTo(VIEW_H_7);
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
        titleLabel.font = [UIFont systemFontOfSize:VIEW_H_1];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        MGYDetailsRelationshipView *relationshipView = [[MGYDetailsRelationshipView alloc] initWithFrame:CGRectZero];
        [self addSubview:relationshipView];
        self.relationshipView = relationshipView;
        
        UILabel *summaryLabel = [UILabel new];
        summaryLabel.numberOfLines = 0;
        summaryLabel.font = [UIFont systemFontOfSize:13];
        summaryLabel.textColor = [UIColor colorWithHexString:@"838383"];
        [self addSubview:summaryLabel];
        self.summaryLabel = summaryLabel;
        
        UIButton *readmoreButton = [UIButton new];
        [self addSubview:readmoreButton];
        readmoreButton.layer.borderWidth = 1;
        readmoreButton.layer.borderColor = [UIColor colorWithHexString:@"f16400"].CGColor;
        [readmoreButton setTitle:NSLocalizedString(@"阅读更多", @"阅读更多")
                        forState:UIControlStateNormal];
        readmoreButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [readmoreButton setTitleColor:[UIColor colorWithHexString:@"f16400"]
                             forState:UIControlStateNormal];
        self.readmoreButton = readmoreButton;
        
        UIView *lineView1 = [self lineViewFactory];
        lineView1.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
        self.lineView1 = lineView1;
        [self addSubview:self.lineView1];
        
        MGYProgressView *progressView = [MGYProgressView new];
        [self addSubview:progressView];
        progressView.backgroundColor = [UIColor clearColor];
        self.progressView = progressView;
        
        MGYDetailsIconListView *iconListView = [MGYDetailsIconListView new];
        [self addSubview:iconListView];
        self.iconListView = iconListView;
        
        UIView *lineView2 = [self lineViewFactory];
        lineView2.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
        self.lineView2 = lineView2;
        [self addSubview:self.lineView2];
        
        UILabel *helpNumLabel = [UILabel new];
        //helpNumLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:helpNumLabel];
        self.helpNumLabel = helpNumLabel;
        
        UIView *lineView3 = [self lineViewFactory];;
        lineView3.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
        self.lineView3 = lineView3;
        [self addSubview:self.lineView3];
        
        UILabel *updateLabel = [UILabel new];
        updateLabel.text = NSLocalizedString(@"近况更新", @"近况更新");
        updateLabel.font = [UIFont systemFontOfSize:14];
        updateLabel.textColor = [UIColor colorWithHexString:@"838383"];
        [self addSubview:updateLabel];
        self.updateLabel = updateLabel;
        
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UIView *)lineViewFactory
{
    UIView *view= [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    return view;
}

- (void)reset:(MGYProjectDetails *)details
{
    [self.detailsImageView sd_setImageWithURL:[NSURL URLWithString:details.detailImg]];
    self.titleLabel.text = details.title;
    [self.relationshipView reset:details];
    self.summaryLabel.text = details.summary;
//    CGSize labelSize = [details.summary boundingRectWithSize:CGSizeMake(512/2, 5000) options:(NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size;
//    self.summaryLabel.frame = CGRectMake(self.summaryLabel.frame.origin.x, self.summaryLabel.frame.origin.y, self.summaryLabel.frame.size.width, labelSize.height);//保持原来Label的位置和宽度，只是改变高度。
//    NSLog(@"uuuuuuuuu %f", labelSize.height);
    [self.iconListView reset:details.riceDonate joinNum:details.joinMemberNum favNum:details.favNum];
    
    [self.progressView resetProgress:details.progress];
    
    NSString *st1 = NSLocalizedString(@"目前为止已经有", @"目前为止已经有");
    NSString *st2 = [NSString stringWithFormat:@"%ld", (long)details.helpMemberNum];
    NSString *st3 = NSLocalizedString(@"帮助过我", @"帮助过我");
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

+ (CGFloat)minHeight
{
    CGFloat height = 0;
    height = OFFSET_Y_1 + OFFSET_Y_2 + OFFSET_Y_3 + OFFSET_Y_4 + OFFSET_Y_5 + OFFSET_Y_6 +OFFSET_Y_7 + OFFSET_Y_8 + VIEW_H_1 + VIEW_H_2 + VIEW_H_3 +VIEW_H_4 + VIEW_H_5 + VIEW_H_6 + VIEW_H_7 + 10;
    return height;
}

@end
