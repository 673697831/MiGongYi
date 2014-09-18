//
//  AboutMeTabButton.m
//  MiGongYi
//
//  Created by megil on 9/16/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "AboutMeItemView.h"
#import "Masonry.h"

@interface AboutMeItemView ()
@property(nonatomic, copy) NSString *normalImagePath;
@property(nonatomic, copy) NSString *selectedImagePath;
@property(nonatomic, copy) NSString *title;
@end

@implementation AboutMeItemView

- (instancetype)initWithFrame:(CGRect)frame
              normalImagePath:(NSString *)normalImagePath
            selectedImagePath:(NSString *)selectedImagePath
                        title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        
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
        [self addSubview:imageView];
        self.myImageView = imageView;
        
        [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_centerY);
        }];
        
        UILabel *label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:9];
        [self addSubview:label];
        self.myLabel = label;
        [self.myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        }];
        
        self.normalImagePath = normalImagePath;
        self.selectedImagePath = selectedImagePath;
        self.title = title;
        [self.myImageView setImage:[UIImage imageNamed:normalImagePath]];
        self.myLabel.text = title;

    }
    return self;
}

- (void)setSelect:(BOOL)isSelected
{
    NSString *path = isSelected ? self.selectedImagePath : self.normalImagePath ;
    UIColor *backgroundColor = isSelected ? [UIColor whiteColor] : [UIColor orangeColor];
    UIColor *textColor = isSelected ? [UIColor orangeColor] : [UIColor whiteColor];
    [self.myImageView setImage:[UIImage imageNamed:path]];
    self.myButton.backgroundColor = backgroundColor;
    self.myLabel.textColor = textColor;
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
