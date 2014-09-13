//
//  DetailsIcon.m
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "DetailsIcon.h"
#import "UIColor+Expanded.h"
#import "Masonry.h"

@implementation DetailsIcon
@synthesize numLabel;
@synthesize imageView;
@synthesize itemLabel;

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
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Args:(NSDictionary *)args
{
    self = [super initWithFrame:frame];
    
    self.numLabel = [[UILabel alloc] init];
    [self addSubview:self.numLabel];
    self.numLabel.text = args[@"num"];
    self.numLabel.textColor = [UIColor colorWithHexString:@"464646"];
    self.numLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
    [self.imageView setImage:[UIImage imageNamed:args[@"path"]]];
    
    self.itemLabel = [[UILabel alloc] init];
    [self addSubview:self.itemLabel];
    self.itemLabel.text = args[@"text"];
    self.itemLabel.textColor = [UIColor colorWithHexString:@"bababa"];
    self.itemLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    
    [self setup];
    return self;
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
