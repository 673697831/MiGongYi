//
//  MGYRiceBoxingDetailsHideView.m
//  MiGongYi
//
//  Created by megil on 11/26/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceBoxingDetailsHideView.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"

@interface MGYRiceBoxingDetailsHideView ()

@property (nonatomic, weak) UIView *view0;
@property (nonatomic, weak) UIView *view1;
@property (nonatomic, weak) UIView *view2;
@property (nonatomic, weak) UIView *view3;

@end

@implementation MGYRiceBoxingDetailsHideView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        for (int i = 0; i < 4; i ++) {
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor colorWithHexString:@"c7c7c7"];
            [self setValue:view
                    forKey:[NSString stringWithFormat:@"view%d",i]];
            [self addSubview:view];
            if (i) {
                UIView *pView = [self valueForKey:[NSString stringWithFormat:@"view%d", i - 1]];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(pView);
                    make.height.equalTo(pView);
                    make.centerX.equalTo(pView);
                    make.top.equalTo(pView.mas_bottom).with.offset(5);
                }];
            }else
            {
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(581.0/2);
                    make.height.mas_equalTo(14);
                    make.centerX.equalTo(self);
                    make.top.equalTo(self);
                }];
            }
        }
    }
    return self;
}

+ (CGFloat)heightForView
{
    return 14 * 4 + 3 * 5;
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
