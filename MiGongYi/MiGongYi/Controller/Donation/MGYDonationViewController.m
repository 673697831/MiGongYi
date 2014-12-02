//
//  ViewController.m
//  MiGongYi
//
//  Created by megil on 11/28/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDonationViewController.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"

@interface MGYDonationViewController ()

@property (nonatomic, weak) UILabel *levelLabel;
@property (nonatomic, weak) UILabel *riceDonateLabel;
@property (nonatomic, weak) UILabel *itemCountLabel;
@property (nonatomic, weak) UILabel *itemRiceDonateLabel;
@property (nonatomic, weak) UILabel *deLabel;
@property (nonatomic, weak) UIButton *shareButton;


@end

@implementation MGYDonationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"一键捐赠";
    
    UILabel *levelLabel = [UILabel new];
    levelLabel.font = [UIFont systemFontOfSize:22/2];
    levelLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
    levelLabel.text = @"LV:18";
    [self.view addSubview:levelLabel];
    self.levelLabel = levelLabel;
    
    UILabel *riceDonateLabel = [UILabel new];
    
    
    // Do any additional setup after loading the view.
    
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(3);
        make.top.equalTo(self.titleView.mas_bottom).with.offset(20);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setSelectedIndex:0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
