//
//  MGYRiceMoveTableViewCell.m
//  MiGongYi
//
//  Created by megil on 11/17/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveTableViewCell.h"

@interface MGYRiceMoveTableViewCell ()

@property (nonatomic, copy) MGYStorySelectCallback selectCallback;
@property (nonatomic, copy) MGYRiceMoveContentViewSelectCallback contentViewSelectCallback;
@property (nonatomic, copy) MGYRiceMoveContentViewDidDisappearCallback contentViewDidDisappearCallback;

@end

@implementation MGYRiceMoveTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        // Do any additional setup after loading the view.
        
        UIImageView *mapImageView = [UIImageView new];
        [self addSubview:mapImageView];
        self.mapImageView = mapImageView;
        
        UIImageView *bookImageView = [UIImageView new];
        UIImage *bookImage = [UIImage imageNamed:@"book_image"];
        bookImage = [bookImage resizableImageWithCapInsets:UIEdgeInsetsMake(22, 20, 23, 20)
                                              resizingMode:UIImageResizingModeStretch];
        [bookImageView setImage:bookImage];
        [self addSubview:bookImageView];
        self.bookImageView = bookImageView;
        
        UILabel *contentLabel = [UILabel new];
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UILabel *conditionLabel = [UILabel new];
        conditionLabel.numberOfLines = 0;
        conditionLabel.font = [UIFont systemFontOfSize:13];
        conditionLabel.textColor = [UIColor colorWithHexString:@"676767"];
        conditionLabel.text = @"过关条件";
        [self addSubview:conditionLabel];
        self.conditionLabel = conditionLabel;
        
        UIImageView *conditionImageView = [UIImageView new];
        [conditionImageView setImage:[UIImage imageNamed:@"red_light"]];
        [self addSubview:conditionImageView];
        self.conditionImageView = conditionImageView;
        
        UILabel *getRiceLabel = [UILabel new];
        getRiceLabel.font = [UIFont systemFontOfSize:18];
        getRiceLabel.text = @"你获得的米数为";
        getRiceLabel.textColor = [UIColor colorWithHexString:@"c7c7c7"];
        [self addSubview:getRiceLabel];
        self.getRiceLabel = getRiceLabel;
        
        UILabel *riceLabel = [UILabel new];
        riceLabel.font = [UIFont systemFontOfSize:39];
        riceLabel.textColor = [UIColor colorWithHexString:@"f16400"];
        [self addSubview:riceLabel];
        self.riceLabel = riceLabel;
        
        [self.mapImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).with.offset(5);
        }];
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(512/2);
            make.centerX.equalTo(self);
            make.top.equalTo(self.mapImageView.mas_bottom).with.offset(30);
        }];
        
        [self.conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).with.offset(50);
            make.centerX.equalTo(self);
        }];
        
        [self.conditionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.conditionLabel);
            make.left.equalTo(self.conditionLabel.mas_right).with.offset(10);
        }];
        
        [getRiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.conditionLabel.mas_bottom).with.offset(50);
            make.centerX.equalTo(self);
        }];
        
        [riceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(getRiceLabel.mas_bottom).with.offset(10);
            make.centerX.equalTo(self);
        }];
        
        [self.bookImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.top.equalTo(self.contentLabel).with.offset(-25);
            make.bottom.equalTo(self.contentLabel).with.offset(25);
            make.centerX.equalTo(self);
        }];
        
        self.conditionLabel.hidden = YES;
        self.conditionImageView.hidden = YES;

    }
    return self;
}

- (void)reset
{
    MGYStoryNode *node = [MGYStoryPlayer defaultPlayer].playNode;
    self.contentLabel.text = node.storyContent;
    [self.mapImageView setImage:[UIImage imageNamed:node.mapIcon]];
    /**
     *  特殊处理 只有一处地方
     */
#warning 剧情
    if ([[MGYStoryPlayer defaultPlayer] isMizhiNode] && false) {
        MGYStoryBranch *branch = node.branch[0];
        self.contentLabel.text = branch.content;
    }
    /**
     *  特殊处理 只有一处地方
     */
#warning 剧情
    if ([[MGYStoryPlayer defaultPlayer] isBoxingNode] && ![[MGYStoryPlayer defaultPlayer] isBoxingAndSelectNode] && false) {
        MGYStoryBranch *branch = node.branch[0];
        self.contentLabel.text = branch.content;
    }

    self.riceLabel.text = [NSString stringWithFormat:@"%ld", (long)node.riceNum];
}

+ (CGFloat)minHeight
{
    return 430;
}


@end
