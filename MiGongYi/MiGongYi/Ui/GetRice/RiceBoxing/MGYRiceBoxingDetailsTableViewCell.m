//
//  MGYRiceBoxingDetailsTableViewCell.m
//  MiGongYi
//
//  Created by megil on 11/15/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceBoxingDetailsTableViewCell.h"
#import "Masonry.h"

@interface MGYRiceBoxingDetailsTableViewCell ()

@property (nonatomic, weak) UILabel *monsterNameLabel;
@property (nonatomic, weak) UILabel *tameLabel;
@property (nonatomic, weak) UIImageView *tameImageView1;
@property (nonatomic, weak) UIImageView *tameImageView2;
@property (nonatomic, weak) UIImageView *tameImageView3;
@property (nonatomic, weak) UIImageView *tameImageView4;
@property (nonatomic, weak) UIImageView *tameImageView5;
@property (nonatomic, weak) UIButton *followButton;
@property (nonatomic, weak) UIImageView *monsterImageView;
@property (nonatomic, weak) UIImageView *manImageView;
@property (nonatomic, weak) UILabel *riceNumLabel;
@property (nonatomic, weak) UILabel *rateLabel;
@property (nonatomic, weak) UILabel *levelLabel;
@property (nonatomic, weak) UILabel *storyLabel;
@property (nonatomic, weak) UILabel *storyContentLabel;
@property (nonatomic, weak) UIView *lineView;

@end
@implementation MGYRiceBoxingDetailsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *monsterNameLabel = [UILabel new];
        monsterNameLabel.font = [UIFont systemFontOfSize:25];
        monsterNameLabel.textAlignment = NSTextAlignmentCenter;
        monsterNameLabel.textColor = [UIColor whiteColor];
        monsterNameLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:monsterNameLabel];
        self.monsterNameLabel = monsterNameLabel;
        
        UILabel *tameLabel = [UILabel new];
        tameLabel.font = [UIFont systemFontOfSize:15];
        tameLabel.textColor = [UIColor grayColor];
        tameLabel.text = @"驯服值";
        [self addSubview:tameLabel];
        self.tameLabel = tameLabel;
        
        for (int i = 1; i <= 5; i ++) {
            UIImageView *imageView = [UIImageView new];
            //[imageView setImage:[UIImage new]]
            imageView.backgroundColor = [UIColor grayColor];
            [self addSubview:imageView];
            [self setValue:imageView
                    forKey:[NSString stringWithFormat:@"tameImageView%d", i]];
        }
        
        [self.monsterNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(20);
            make.right.equalTo(self).with.offset(-20);
            make.height.mas_offset(40);
            make.top.equalTo(self).with.offset(20);
        }];
        
        [self.tameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.monsterNameLabel.mas_bottom).with.offset(20);
        }];
        
        [self.tameImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(10);
            make.width.mas_equalTo(10);
            make.centerX.equalTo(self);
            make.top.equalTo(self.tameLabel.mas_bottom).with.offset(10);
        }];
        
        [self.tameImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.tameImageView3);
            make.width.equalTo(self.tameImageView3);
            make.centerY.equalTo(self.tameImageView3);
            make.right.equalTo(self.tameImageView3.mas_left).with.offset(-5);
        }];
        
        [self.tameImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.tameImageView3);
            make.width.equalTo(self.tameImageView3);
            make.centerY.equalTo(self.tameImageView3);
            make.right.equalTo(self.tameImageView2.mas_left).with.offset(-5);
        }];
        
        [self.tameImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.tameImageView3);
            make.width.equalTo(self.tameImageView3);
            make.centerY.equalTo(self.tameImageView3);
            make.left.equalTo(self.tameImageView3.mas_right).with.offset(5);
        }];
        
        [self.tameImageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.tameImageView3);
            make.width.equalTo(self.tameImageView3);
            make.centerY.equalTo(self.tameImageView3);
            make.left.equalTo(self.tameImageView4.mas_right).with.offset(5);
        }];
    }
    return self;
}

- (void)setDetails:(MGYMonster *)monster
{
    self.monsterNameLabel.text = monster.monsterName;
}

@end
