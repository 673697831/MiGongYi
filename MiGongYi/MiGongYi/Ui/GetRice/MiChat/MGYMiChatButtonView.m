//
//  MGYMiChatButtonView.m
//  MiGongYi
//
//  Created by megil on 9/30/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiChatButtonView.h"
#import "Masonry.h"

@interface MGYMiChatButtonView ()

@property(nonatomic, weak) UIButton *button1;
@property(nonatomic, weak) UIButton *button2;
@property(nonatomic, weak) UIButton *button3;
@property(nonatomic ,weak) UIButton *button4;
@property(nonatomic, weak) UIButton *button5;
@property(nonatomic ,weak) UIButton *button6;

@end

@implementation MGYMiChatButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIButton *button1 = [UIButton new];
        [button1 setTitle:@"头像" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //button1.backgroundColor = [UIColor yellowColor];
        [self addSubview:button1];
        self.button1 = button1;
        
        UIButton *button2 = [UIButton new];
        [button2 setTitle:@"名字" forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //button2.backgroundColor = [UIColor blueColor];
        [self addSubview:button2];
        self.button2 = button2;
        
        UIButton *button3 = [UIButton new];
        [button3 setTitle:@"前进" forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button3 addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        //button3.backgroundColor = [UIColor blackColor];
        [self addSubview:button3];
        self.button3 = button3;
        
        UIButton *button4 = [UIButton new];
        [button4 setTitle:@"返回" forState:UIControlStateNormal];
        [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //button4.backgroundColor = [UIColor yellowColor];
        [self addSubview:button4];
        self.button4 = button4;
        
        UIButton *button5 = [UIButton new];
        [button5 setTitle:@"一天3次" forState:UIControlStateNormal];
        [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //button5.backgroundColor = [UIColor blueColor];
        [self addSubview:button5];
        self.button5 = button5;
        
        UIButton *button6 = [UIButton new];
        [button6 setTitle:@"删除" forState:UIControlStateNormal];
        [button6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //button6.backgroundColor = [UIColor blackColor];
        [self addSubview:button6];
        self.button6 = button6;
        
        [self setup];
    }
    return self;
}

- (void)clickEvent:(id)sender
{
    NSLog(@"ppppppppp");
}

- (void)setup
{
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_height);
        make.height.equalTo(self.mas_height);
        make.left.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_height);
        make.height.equalTo(self.mas_height);
        make.right.equalTo(self.mas_centerX);
        make.bottom.equalTo(self);
    }];
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height);
        make.bottom.equalTo(self);
        make.left.equalTo(self.button1.mas_right);
        make.right.equalTo(self.button3.mas_left);
    }];
    
    [self.button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_height);
        make.height.equalTo(self.mas_height);
        make.bottom.equalTo(self);
    }];
    
    [self.button6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.width.equalTo(self.mas_height);
        make.height.equalTo(self.mas_height);
        make.bottom.equalTo(self);
    }];
    
    [self.button5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height);
        make.bottom.equalTo(self);
        make.left.equalTo(self.button4.mas_right);
        make.right.equalTo(self.button6.mas_left);
    }];
}

- (void)reset:(NSString *)peopleName
{
    [self.button2 setTitle:peopleName forState:UIControlStateNormal];
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
