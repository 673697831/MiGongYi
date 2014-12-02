//
//  MGYRiceBoxingTimesTipsView.m
//  MiGongYi
//
//  Created by megil on 11/30/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceBoxingTimesTipsView.h"
#import "Masonry.h"

@interface MGYRiceBoxingTimesTipsView ()

@property (nonatomic, weak) UIButton *hideButton;
@property (nonatomic, weak) UIImageView *noTimesImageView;

@end

@implementation MGYRiceBoxingTimesTipsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIButton *hideButton = [UIButton new];
        [hideButton addTarget:self
                       action:@selector(hideSelf)
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hideButton];
        self.hideButton = hideButton;
        
        UIImageView *noTimesImageView = [UIImageView new];
        noTimesImageView.image = [UIImage imageNamed:@"none_times"];
        [self addSubview:noTimesImageView];
        self.noTimesImageView = noTimesImageView;
        
        [self.hideButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.noTimesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        
    }
    return self;
}

- (void)hideSelf
{
    self.hidden = YES;
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
