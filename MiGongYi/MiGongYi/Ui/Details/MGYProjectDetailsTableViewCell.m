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

@interface MGYProjectDetailsTableViewCell ()

@property(nonatomic, weak) UIImageView *detailsImageView;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) MGYDetailsRelationshipView *relationshipView;

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
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)update:(MGYProjectDetails *)details
{
    [self.detailsImageView sd_setImageWithURL:[NSURL URLWithString:details.detailImg]];
    self.titleLabel.text = details.title;
    [self.relationshipView update:details];
    NSLog(@"iiiiiii %@", details.title);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
