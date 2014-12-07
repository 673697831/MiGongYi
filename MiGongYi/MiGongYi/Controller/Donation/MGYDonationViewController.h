//
//  ViewController.h
//  MiGongYi
//
//  Created by megil on 11/28/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYSubViewController.h"
#import "MGYDonationCommentView.h"
#import "MGYDonationTableViewCell.h"

@interface MGYDonationViewController : MGYBaseViewController<UITableViewDelegate, UITableViewDataSource, MGYDonationCommentViewDelegate, UITextFieldDelegate, MGYDonationTableViewCellDelegate>

@end
