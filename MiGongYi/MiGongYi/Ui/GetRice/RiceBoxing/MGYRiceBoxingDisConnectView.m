//
//  MGYRiceBoxingDisConnectView.m
//  MiGongYi
//
//  Created by megil on 12/1/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceBoxingDisConnectView.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"

@interface MGYRiceBoxingDisConnectView ()

@property (nonatomic, weak) UIView *blueView;
@property (nonatomic, weak) UIImageView *warningView;
@property (nonatomic ,weak) UILabel *connectLabel;
@property (nonatomic, weak) UILabel *disConnectLabel;
@property (nonatomic, weak) UIButton *canselButton;
@property (nonatomic, weak) UIButton *connectButton;
@property (nonatomic, weak) CustomIOS7AlertView *alertView;

@end

@implementation MGYRiceBoxingDisConnectView

-(instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 420/2, 286/2)];
    if (self) {
        
        UIView *blueView = [UIView new];
        blueView.backgroundColor = [UIColor colorWithHexString:@"a2dcf4"];
        [self addSubview:blueView];
        self.blueView = blueView;
        
        UIImageView *warningView = [UIImageView new];
        warningView.contentMode = UIViewContentModeScaleAspectFit;
        warningView.image = [UIImage imageNamed:@"button_warn_normal"];
        [self addSubview:warningView];
        self.warningView = warningView;
        
        UILabel *connectLabel = [UILabel new];
        connectLabel.font = [UIFont systemFontOfSize:14];
        connectLabel.textColor = [UIColor colorWithHexString:@"f16400"];
        connectLabel.text = @"连接到服务器?";
        [self addSubview:connectLabel];
        self.connectLabel = connectLabel;
        
        UILabel *disConnectLabel = [UILabel new];
        disConnectLabel.font = [UIFont systemFontOfSize:12];
        disConnectLabel.textColor = [UIColor colorWithHexString:@"666666"];
        disConnectLabel.text = @"你目前还未连接服务器";
        [self addSubview:disConnectLabel];
        self.disConnectLabel = disConnectLabel;
        
        UIButton *canselButton = [UIButton new];
        [canselButton addTarget:self
                         action:@selector(closeSelf:)
               forControlEvents:UIControlEventTouchUpInside];
        canselButton.backgroundColor = [UIColor grayColor];
        [canselButton setTitle:@"取消" forState:UIControlStateNormal];
        [canselButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:canselButton];
        self.canselButton = canselButton;
        
        UIButton *connectButton = [UIButton new];
        [connectButton addTarget:self
                          action:@selector(closeSelf:)
               forControlEvents:UIControlEventTouchUpInside];
        connectButton.backgroundColor = [UIColor colorWithHexString:@"f16400"];
        [connectButton setTitle:@"连接" forState:UIControlStateNormal];
        [connectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:connectButton];
        self.connectButton = connectButton;
        
        [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        
        [self.warningView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(24);
            make.height.mas_equalTo(24);
            make.left.equalTo(self).with.offset(23.0/2);
            make.centerY.equalTo(self.blueView);
        }];
        
        [self.connectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.blueView);
            make.centerX.equalTo(self.blueView);
        }];
        
        [self.disConnectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.warningView);
            make.centerY.equalTo(self);
        }];
        
        [self.canselButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(178/2);
            make.height.mas_equalTo(35);
            make.left.equalTo(self.warningView);
            make.bottom.equalTo(self).with.offset(-9);
        }];
        
        [self.connectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.canselButton);
            make.height.equalTo(self.canselButton);
            make.right.equalTo(self).with.offset(-23.0/2);
            make.bottom.equalTo(self.canselButton);
        }];
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self show];
    }
    return self;
}

- (void)closeSelf:(id)sender
{
    if (sender == self.canselButton&&self.disconnectDelegate) {
        [self.disconnectDelegate riceBoxingCansel];
    }
    
    if (sender == self.connectButton&&self.disconnectDelegate) {
        [self.disconnectDelegate riceBoxingConnect];
    }
    [self.alertView close];
}

- (void)close
{
    [self.alertView close];
}

- (void)show
{
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    [alertView addSubview:self];
    [alertView setButtonTitles:NULL];
    
    // Add some custom content to the alert view
    [alertView setContainerView:self];
    [alertView setUseMotionEffects:true];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(420/2);
        make.height.mas_equalTo(286/2);
        make.centerX.equalTo(alertView);
        make.centerY.equalTo(alertView);
    }];
    
    self.alertView = alertView;
    
    // And launch the dialog
    [alertView show];
    
}

- (void)dealloc
{
    self.alertView = nil;
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
