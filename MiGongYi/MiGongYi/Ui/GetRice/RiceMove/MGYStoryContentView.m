//
//  MGYStoryContentView.m
//  MiGongYi
//
//  Created by megil on 11/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYStoryContentView.h"
#import "Masonry.h"

@interface MGYStoryContentView ()

@property (nonatomic, weak) UIButton *clickButton;
@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation MGYStoryContentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UILabel *contentLabel = [UILabel new];
        contentLabel.backgroundColor = [UIColor whiteColor];
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UIButton *clickButton = [UIButton new];
        [clickButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clickButton];
        self.clickButton = clickButton;
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(512/2);
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        
        [clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
    }
    return self;
}

- (void)click:(id)sender
{
    NSLog(@"uuuuuuuuuuu");
    self.hidden = YES;
}

- (void)resetContent:(NSString *)content
{
    self.contentLabel.text = content;
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
