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

- (instancetype)initWithType:(MGYDetailsIconFontColorType)type
{
    self = [super init];
    if (self) {
        // Initialization code
        UILabel *numLabel = [UILabel new];
        self.numLabel = numLabel;
        [self addSubview:self.numLabel];
        self.numLabel.textColor = [UIColor colorWithHexString:[self numberColorByType:type]];
        self.numLabel.font = [UIFont systemFontOfSize:16];
        
        UIImageView *imageView = [UIImageView new];
        self.imageView = imageView;
        [self addSubview:self.imageView];
        
        UILabel *itemLabel = [UILabel new];
        self.itemLabel = itemLabel;
        [self addSubview:self.itemLabel];
        self.itemLabel.textColor = [UIColor colorWithHexString:[self itemColorByType:type]];
        self.itemLabel.font = [UIFont systemFontOfSize:10];
        
        [self setup];
    }
    return self;
}

- (void)resetDetails:(NSString *)num path:(NSString *)path text:(NSString *)text
{
    self.numLabel.text = num;
    if (path) {
        self.imageView.image = [UIImage imageNamed:path];
    }
    if (text) {
        self.itemLabel.text = text;
    }
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
