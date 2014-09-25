//
//  AboutMeViewController.h
//  MiGongYi
//
//  Created by megil on 9/19/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYBaseViewController.h"
#import "MGYAboutMeTableViewCell.h"

@interface MGYAboutMeViewController : MGYBaseViewController<UITableViewDelegate, UITableViewDataSource, MGYAboutMeTableViewCellDelegate>

@end
