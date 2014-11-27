//
//  MGYRiceBoxingDetailsViewController.h
//  MiGongYi
//
//  Created by megil on 11/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYSubViewController.h"
#import "MGYRiceBoxingDetailsTableViewCell.h"

@interface MGYRiceBoxingDetailsViewController : MGYSubViewController<UITableViewDelegate, UITableViewDataSource, MGYRiceBoxingDetailsTableViewCellDelegate>

- (instancetype)initWithMonsterId:(NSInteger)monsterId;

@end
