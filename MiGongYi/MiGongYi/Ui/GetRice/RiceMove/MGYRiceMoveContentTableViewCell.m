//
//  MGYRiceMoveContentTableViewCell.m
//  MiGongYi
//
//  Created by megil on 11/17/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveContentTableViewCell.h"

@interface MGYRiceMoveContentTableViewCell ()

@property (nonatomic, weak) UIButton *goAheadButton;
@property (nonatomic, weak) UIButton *shareButton;

@end

@implementation MGYRiceMoveContentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIButton *goAheadButton = [UIButton new];
        goAheadButton.backgroundColor = [UIColor colorWithHexString:@"a2dcf4"];
        [goAheadButton setTitle:@"继续挑战"
                       forState:UIControlStateNormal];
        [goAheadButton setTitleColor:[UIColor whiteColor]
                            forState:UIControlStateNormal];
        
        [goAheadButton addTarget:self
                          action:@selector(click:)
                forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:goAheadButton];
        self.goAheadButton = goAheadButton;
        
        UIButton *shareButton = [UIButton new];
        shareButton.backgroundColor = [UIColor orangeColor];
        [shareButton setTitleColor:[UIColor whiteColor]
                          forState:UIControlStateNormal];
        [shareButton setTitle:@"分享"
                     forState:UIControlStateNormal];
        
        [self addSubview:shareButton];
        self.shareButton = shareButton;
        
        [self.goAheadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.riceLabel.mas_bottom).with.offset(20);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(270/2);
            make.centerX.equalTo(self);
        }];
        
        [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goAheadButton.mas_bottom).with.offset(20);
            make.height.equalTo(self.goAheadButton);
            make.width.equalTo(self.goAheadButton);
            make.centerX.equalTo(self.goAheadButton);
        }];
        
    }
    return self;
}

- (void)reset
{
    [super reset];
}

- (void)click:(id)sender
{
    [self.cellDelegate disappearFromClickButton];
}

@end
