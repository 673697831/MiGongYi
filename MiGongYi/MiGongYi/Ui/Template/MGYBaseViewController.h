//
//  MGYBaseViewController.h
//  MiGongYi
//
//  Created by megil on 9/12/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYBaseProgressView.h"
#import "MBProgressHUD.h"

@protocol MGYBaseViewControllerProtocol <NSObject>

- (void)refreshView:(UIRefreshControl *)refreshControl;

@end

@interface MGYBaseViewController : UIViewController<UITabBarDelegate>

@property(nonatomic, weak) UILabel *textLabel;
@property(nonatomic, weak) MGYBaseProgressView *titleView;
@property(nonatomic, weak) UITabBar *barView;

- (void)setSelectedIndex:(NSInteger) selectedIndex;
@end
