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
    
    UILabel *levelLabel = [UILabel new];
    levelLabel.font = [UIFont systemFontOfSize:22/2];
    levelLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
    levelLabel.text = @"LV:18";
    [self.view addSubview:levelLabel];
    
    self.title = @"一键捐赠";
    // Do any additional setup after loading the view.
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
