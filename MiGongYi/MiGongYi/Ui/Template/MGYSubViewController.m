//
//  MGYSubViewController.m
//  MiGongYi
//
//  Created by megil on 9/30/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYSubViewController.h"

@interface MGYSubViewController ()

@end

@implementation MGYSubViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.barView.hidden = YES;
    self.navigationItem.rightBarButtonItem = nil;
    //[self.navigationItem setTitleView:<#(UIView *)#>];
    // 自定义返回
    //    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"< 返回" style:UIBarButtonItemStyleBordered target:self action:@selector(click)];
    //    //UIButton *button;
    //    backItem.tintColor = [UIColor whiteColor];
    //    self.navigationItem.leftBarButtonItem = backItem;
    
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%f %f", self.titleView.bounds.size.width, self.titleView.bounds.size.height);
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
