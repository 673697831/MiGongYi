//
//  MGYRiceMoveContentTableViewCell.m
//  MiGongYi
//
//  Created by megil on 11/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveDetailsTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"

@interface MGYRiceMoveDetailsTableViewCell ()

@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIImageView *littleImageView;
@property (nonatomic, weak) UIView *lineView;

@end

@implementation MGYRiceMoveDetailsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel *contentLabel = [UILabel new];
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:11];
        contentLabel.textColor = [UIColor colorWithHexString:@"464646"];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor colorWithHexString:@"f16400"];
        [self addSubview:lineView];
        self.lineView = lineView;
        
        UILabel *dateLabel = [UILabel new];
        dateLabel.textColor = [UIColor colorWithHexString:@"838383"];
        dateLabel.font = [UIFont systemFontOfSize:9];
        [self addSubview:dateLabel];
        self.dateLabel = dateLabel;
        
        UIImageView *littleImageView = [UIImageView new];
        [littleImageView setImage:[UIImage imageNamed:@"littleMan2"]];
        [self addSubview:littleImageView];
        self.littleImageView = littleImageView;
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
            make.width.equalTo(self);
            make.centerX.equalTo(self);
            make.top.equalTo(self).with.offset(11);
        }];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView.mas_bottom).with.offset(7);
            make.centerX.equalTo(self);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.edges.equalTo(self);
            make.centerX.equalTo(self);
            make.width.mas_equalTo(400/2);
            make.top.equalTo(self.dateLabel.mas_bottom).with.offset(9);
        }];
        
        [self.littleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView.mas_bottom).with.offset(49.0/2);
            make.left.equalTo(self).with.offset(22);
        }];
        
    }
    return self;
}

- (void)resetContent:(NSString *)content
          dateString:(NSString *)dateString
{
    self.contentLabel.text = content;
    self.dateLabel.text = dateString;
}

@end
