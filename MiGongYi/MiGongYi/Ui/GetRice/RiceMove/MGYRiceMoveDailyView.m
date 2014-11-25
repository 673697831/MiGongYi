//
//  MGYRiceMoveDailyView.m
//  MiGongYi
//
//  Created by megil on 11/17/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveDailyView.h"
#import "UIColor+Expanded.h"
#import "Masonry.h"

@interface MGYRiceMoveDailyView ()

@property (nonatomic, weak) UILabel *myContentLabel;
@property (nonatomic, weak) UIButton *hideButton;

@end

@implementation MGYRiceMoveDailyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UILabel *myContentLabel = [UILabel new];
        myContentLabel.font = [UIFont systemFontOfSize:9];
        myContentLabel.backgroundColor = [UIColor whiteColor];
        myContentLabel.textColor = [UIColor colorWithHexString:@"838383"];
        myContentLabel.numberOfLines = 0;
        [self addSubview:myContentLabel];
        self.myContentLabel = myContentLabel;
        
        UIButton *hideButton = [UIButton new];
        [hideButton addTarget:self
                       action:@selector(click:)
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hideButton];
        self.hideButton = hideButton;
        
        [self.myContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(27);
            make.right.equalTo(self).with.offset(-27);
            make.top.equalTo(self);
        }];
        
        [self.hideButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setText:(NSString *)text
{

}

- (void)click:(id)sender
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
