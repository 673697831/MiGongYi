//
//  AboutMeTabButton.m
//  MiGongYi
//
//  Created by megil on 9/16/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "AboutMeItemView.h"
#import "Masonry.h"

@implementation AboutMeItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initialize:(NSString *)imagePath text:(NSString *)text
{
    UIButton *button = [UIButton new];
    [self addSubview:button];
    self.myButton = button;
    button.backgroundColor = [UIColor orangeColor];
    [self.myButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    UIImageView *imageView = [UIImageView new];
    [imageView setImage:[UIImage imageNamed:imagePath]];
    [self addSubview:imageView];
    self.myImageView = imageView;
    
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_centerY);
    }];
    
    UILabel *label = [UILabel new];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:9];
    [self addSubview:label];
    self.myLabel = label;
    [self.myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
    }];

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
