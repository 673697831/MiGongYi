//
//  MGYDetailsIconListView.m
//  MiGongYi
//
//  Created by megil on 9/22/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDetailsIconListView.h"
#import "UIColor+Expanded.h"
#import "Masonry.h"

@interface MGYDetailsIconListView ()

@property(nonatomic, weak) MGYDetailsIcon *riceIconView;
@property(nonatomic, weak) MGYDetailsIcon *joinIconView;
@property(nonatomic, weak) MGYDetailsIcon *favIconView;
@property(nonatomic, weak) UILabel *label1;
@property(nonatomic, weak) UILabel *label2;

@end

@implementation MGYDetailsIconListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initSubView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView
{
    MGYDetailsIcon *riceIconView = [[MGYDetailsIcon alloc] initWithFrame:CGRectMake(0, 0, 552/3/2, 104/2)];
    [riceIconView resetDetails:@"355580"
                          path:@"page_Rice_normal2"
                          text:@"捐赠米粒"];
    [riceIconView resetFontColor:@"676767" itemColor:@"838383"];
    [self addSubview:riceIconView];
    self.riceIconView = riceIconView;
    
    MGYDetailsIcon *joinIconView = [[MGYDetailsIcon alloc] initWithFrame:CGRectMake(0, 0, 552/3/2, 104/2)];
    [joinIconView resetDetails:@"355580"
                          path:@"page_People_normal2"
                          text:@"参与人数"];
    [joinIconView resetFontColor:@"676767" itemColor:@"838383"];
    [self addSubview:joinIconView];
    self.joinIconView = joinIconView;
    
    MGYDetailsIcon *favIconView = [[MGYDetailsIcon alloc] initWithFrame:CGRectMake(0, 0, 552/3/2, 104/2)];
    [favIconView resetDetails:@"355580"
                         path:@"page_Fav_normal2"
                         text:@"收藏次数"];
    [favIconView resetFontColor:@"676767" itemColor:@"838383"];
    [self addSubview:favIconView];
    self.favIconView = favIconView;
    
    UILabel *label1 = [UILabel new];
    [self addSubview:label1];
    label1.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    self.label1 = label1;
    
    UILabel *label2 = [UILabel new];
    [self addSubview:label2];
    label2.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    self.label2 = label2;
    
    [self setup];
}

- (void)setup
{
    [self.joinIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.height.equalTo(self.mas_height);
        make.width.mas_equalTo(self.bounds.size.width / 3);
    }];
    
    [self.riceIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height);
        make.width.mas_equalTo(self.bounds.size.width / 3);
        make.centerY.equalTo(self);
        make.right.equalTo(self.joinIconView.mas_left);
    }];
    
    [self.favIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height);
        make.width.mas_equalTo(self.bounds.size.width / 3);
        make.centerY.equalTo(self);
        make.left.equalTo(self.joinIconView.mas_right);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.equalTo(self);
        make.centerY.equalTo(self);
        make.left.equalTo(self.joinIconView);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.equalTo(self);
        make.centerY.equalTo(self);
        make.right.equalTo(self.joinIconView);
    }];
}

- (void)reset:(NSInteger)riceNum joinNum:(NSInteger)joinNum favNum:(NSInteger)favNum
{
    [self.riceIconView resetDetails:[NSString stringWithFormat:@"%d", riceNum] path:nil text:nil];
    [self.joinIconView resetDetails:[NSString stringWithFormat:@"%d", joinNum] path:nil text:nil];
    [self.favIconView resetDetails:[NSString stringWithFormat:@"%d", favNum] path:nil text:nil];
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
