//
//  DetailsIcon.m
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDetailsIcon.h"
#import "UIColor+Expanded.h"
#import "Masonry.h"

@implementation MGYDetailsIcon

- (void)setup
{
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(self.numLabel.mas_bottom).with.offset(2);
        make.centerY.equalTo(self);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (instancetype)initWithType:(MGYDetailsIconType)type
                   colorType:(MGYDetailsIconFontColorType)colorType
{
    self = [super init];
    if (self) {
        // Initialization code
        UILabel *numLabel = [UILabel new];
        self.numLabel = numLabel;
        [self addSubview:self.numLabel];
        self.numLabel.textColor = [UIColor colorWithHexString:[self numberColorByType:colorType]];
        self.numLabel.font = [UIFont systemFontOfSize:16];
        
        UIImageView *imageView = [UIImageView new];
        [imageView setImage:[UIImage imageNamed:[self imagePath:type]]];
        self.imageView = imageView;
        [self addSubview:self.imageView];
        
        UILabel *itemLabel = [UILabel new];
        self.itemLabel = itemLabel;
        itemLabel.text = [self itemName:type];
        [self addSubview:self.itemLabel];
        self.itemLabel.textColor = [UIColor colorWithHexString:[self itemColorByType:colorType]];
        self.itemLabel.font = [UIFont systemFontOfSize:10];
        
        [self setup];
    }
    return self;
}

- (void)reset:(NSString *)num
{
    self.numLabel.text = num;
}

#pragma mark - 字体颜色样式
- (NSString *)numberColorByType:(MGYDetailsIconFontColorType)type
{
    NSArray *array = @[@"464646", @"676767"];
    return array[type];
}

- (NSString *)itemColorByType:(MGYDetailsIconFontColorType)type
{
    NSArray *array = @[@"bababa", @"838383"];
    return array[type];
}

#pragma mark - 视图样式
- (NSString *)imagePath:(MGYDetailsIconType)type
{
    NSArray *array = @[@"page_Rice_normal2", @"page_People_normal2", @"page_Fav_normal2"];
    return array[type];
}

- (NSString *)itemName:(MGYDetailsIconType)type
{
    NSArray *array = @[NSLocalizedString(@"捐赠米粒", @"捐赠米粒"), NSLocalizedString(@"参与人数", @"参与人数"), NSLocalizedString(@"收藏次数", @"收藏次数")];
    return array[type];
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
