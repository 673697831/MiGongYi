//
//  MGYRiceMoveSelectTableViewCell.m
//  MiGongYi
//
//  Created by megil on 11/17/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveSelectTableViewCell.h"

@interface MGYRiceMoveSelectTableViewCell ()

@property (nonatomic, weak) UIButton *leftButton;
@property (nonatomic, weak) UIButton *rightButton;
@property (nonatomic, weak) UIButton *shareButton;

@end

@implementation MGYRiceMoveSelectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIButton *leftButton = [UIButton new];
        leftButton.backgroundColor  = [UIColor colorWithHexString:@"a2dcf4"];
        [leftButton setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
        [leftButton addTarget:self
                       action:@selector(click:)
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftButton];
        self.leftButton = leftButton;
        
        UIButton *rightButton = [UIButton new];
        rightButton.backgroundColor  = [UIColor colorWithHexString:@"a2dcf4"];
        [rightButton setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
        [rightButton addTarget:self
                        action:@selector(click:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightButton];
        self.rightButton = rightButton;
        
        UIButton *shareButton = [UIButton new];
        shareButton.backgroundColor  = [UIColor orangeColor];
        [shareButton setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
        [shareButton setTitle:@"分享"
                     forState:UIControlStateNormal];
        [self addSubview:shareButton];
        self.shareButton = shareButton;
        
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(270/2);
            make.top.equalTo(self.riceLabel.mas_bottom).with.offset(20);
            make.left.equalTo(self).with.offset(20);
        }];
        
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.leftButton);
            make.width.equalTo(self.leftButton);
            make.top.equalTo(self.leftButton);
            make.right.equalTo(self).with.offset(-20);
        }];
        
        [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.leftButton);
            make.width.equalTo(self.leftButton);
            make.top.equalTo(self.leftButton.mas_bottom).with.offset(20);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

- (void)reset
{
    [super reset];
    MGYStoryNode *node = [MGYStoryPlayer defaultPlayer].playNode;
    
    if(node.branch.count > 1)
    {
        MGYStoryBranch *branch0 = node.branch[0];
        MGYStoryBranch *branch1 = node.branch[1];
        [self.leftButton setTitle:branch0.title
                         forState:UIControlStateNormal];
        [self.rightButton setTitle:branch1.title
                          forState:UIControlStateNormal];
    }
    
}

- (void)click:(id)sender
{
    MGYStoryNode *node = [MGYStoryPlayer defaultPlayer].playNode;
    MGYStoryBranch *branch0 = node.branch[0];
    MGYStoryBranch *branch1 = node.branch[1];
    
    if (sender == self.leftButton) {
        [self.cellDelegate selectBranch:branch0];
    }
    if (sender == self.rightButton) {
#warning 剧情
        if ([[MGYStoryPlayer defaultPlayer] isBoxingNode] ) {
            branch1 = node.branch[2];
            [[MGYStoryPlayer defaultPlayer] openBoxingBranch];
        }
        [self.cellDelegate selectBranch:branch1];
    }
}

@end
