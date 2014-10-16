//
//  MGYMiChatPhoneListView.m
//  MiGongYi
//
//  Created by megil on 10/16/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiChatPhoneListView.h"
#import "Masonry.h"

@interface MGYMiChatPhoneListView ()
{
    NSMutableArray *_array;
}

//@property(nonatomic, strong) NSArray *viewList;

@end

@implementation MGYMiChatPhoneListView

- (instancetype)initPhoneList:(NSArray *)phoneList
{
    self = [super init];
    if (self) {
        //_array = [NSMutableArray array];
        __weak UIButton *lastButton;
        for (int i = 0; i < phoneList.count; i++) {
            UIButton *button = [UIButton new];
            [button setTitleColor:[UIColor blackColor]
                         forState:UIControlStateNormal];
            [button addTarget:self
                       action:@selector(buttonClick:)
             forControlEvents:UIControlEventTouchUpInside];
            //button.titleLabel.font = [UIFont systemFontOfSize:21];
            [button setTitle:phoneList[i]
                    forState:UIControlStateNormal];
            [self addSubview:button];
            if (i == 0) {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(59);
                    make.width.equalTo(self);
                    make.left.equalTo(self);
                    make.top.equalTo(self);
                }];
            }else
            {
                //UIButton *lastButton = _array[i - 1];
                
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(59);
                    make.width.equalTo(self);
                    make.left.equalTo(self);
                    make.top.equalTo(lastButton.mas_bottom);
                }];
            }
            [_array addObject:button];
            lastButton = button;
        }
        lastButton = nil;
    }
    return self;
}

- (void)buttonClick:(id)sender
{
    UIButton *button = sender;
    NSLog(@"fuck~~~~~~ %@", button.currentTitle);
    [self.myDelegate selectNumber:button.currentTitle];
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
