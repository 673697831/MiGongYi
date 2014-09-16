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
        make.top.equalTo(self.mas_top).with.offset(2);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numLabel.mas_bottom).with.offset(2);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).with.offset(2);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *numLabel = [UILabel new];
        self.numLabel = numLabel;
        [self addSubview:self.numLabel];
        self.numLabel.textColor = [UIColor colorWithHexString:@"464646"];
        self.numLabel.font = [UIFont systemFontOfSize:16];
        
        UIImageView *imageView = [UIImageView new];
        self.imageView = imageView;
        [self addSubview:self.imageView];
        
        UILabel *itemLabel = [UILabel new];
        self.itemLabel = itemLabel;
        [self addSubview:self.itemLabel];
        self.itemLabel.textColor = [UIColor colorWithHexString:@"bababa"];
        self.itemLabel.font = [UIFont systemFontOfSize:10];
        
        [self setup];
    }
    return self;
}

- (void)resetArgs:(NSDictionary *)args
{
    self.numLabel.text = args[@"num"];
    [self.imageView setImage:[UIImage imageNamed:args[@"path"]]];
    self.itemLabel.text = args[@"text"];
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
