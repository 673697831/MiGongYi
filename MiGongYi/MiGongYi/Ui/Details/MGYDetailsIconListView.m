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
@property(nonatomic, weak) UIView *view1;
@property(nonatomic, weak) UIView *view2;

@end

@implementation MGYDetailsIconListView

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
    MGYDetailsIcon *riceIconView = [[MGYDetailsIcon alloc] initWithType:MGYDetailsIconTypeRice
                                                              colorType:MGYDetailsIconFontColorType2];
//    [riceIconView resetDetails:@"0"
//                          path:@"page_Rice_normal2"
//                          text:@"捐赠米粒"];
    [self addSubview:riceIconView];
    self.riceIconView = riceIconView;
    
    MGYDetailsIcon *joinIconView = [[MGYDetailsIcon alloc] initWithType:MGYDetailsIconTypePeople
                                                              colorType:MGYDetailsIconFontColorType2];
//    [joinIconView resetDetails:@"355580"
//                          path:@"page_People_normal2"
//                          text:@"参与人数"];
    [self addSubview:joinIconView];
    self.joinIconView = joinIconView;
    
    MGYDetailsIcon *favIconView = [[MGYDetailsIcon alloc] initWithType:MGYDetailsIconTypeFav
                                                             colorType:MGYDetailsIconFontColorType2];
//    [favIconView resetDetails:@"355580"
//                         path:@"page_Fav_normal2"
//                         text:@"收藏次数"];
    [self addSubview:favIconView];
    self.favIconView = favIconView;
    
    UIView *view1 = [UIView new];
    [self addSubview:view1];
    view1.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    self.view1 = view1;
    
    UIView *view2 = [UIView new];
    [self addSubview:view2];
    view2.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    self.view2 = view2;
    
    [self setup];
}

- (void)setup
{
    [self.joinIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.height.equalTo(self.mas_height);
        make.width.equalTo(self).with.multipliedBy(1.0/3);
        //make.width.mas_equalTo(self.bounds.size.width / 3);
    }];
    
    [self.riceIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height);
        make.width.equalTo(self).with.multipliedBy(1.0/3);
        //make.width.mas_equalTo(self.bounds.size.width / 3);
        make.centerY.equalTo(self);
        make.right.equalTo(self.joinIconView.mas_left);
    }];
    
    [self.favIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height);
        make.width.equalTo(self).with.multipliedBy(1.0/3);
        //make.width.mas_equalTo(self.bounds.size.width / 3);
        make.centerY.equalTo(self);
        make.left.equalTo(self.joinIconView.mas_right);
    }];
    
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.height.equalTo(self);
        make.centerY.equalTo(self);
        make.left.equalTo(self.joinIconView);
    }];
    
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.height.equalTo(self);
        make.centerY.equalTo(self);
        make.right.equalTo(self.joinIconView);
    }];
}

- (void)reset:(NSInteger)riceNum joinNum:(NSInteger)joinNum favNum:(NSInteger)favNum
{
    [self.riceIconView reset:[NSString stringWithFormat:@"%ld", (long)riceNum]];
    [self.joinIconView reset:[NSString stringWithFormat:@"%ld", (long)joinNum]];
    [self.favIconView reset:[NSString stringWithFormat:@"%ld", (long)favNum]];
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
