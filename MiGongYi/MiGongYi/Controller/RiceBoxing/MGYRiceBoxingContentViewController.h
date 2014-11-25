//
//  MGYRiceBoxingContentViewController.h
//  MiGongYi
//
//  Created by megil on 11/24/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYSubViewController.h"
#import "MGYGetRiceDisappearDelegate.h"
#import "MGYBoxingRecord.h"

@interface MGYRiceBoxingContentViewController : MGYSubViewController<UITableViewDelegate, UITableViewDataSource, MGYGetRiceCellDelegate>

- (instancetype)initWithMonster:(MGYMonster *)monster;

@end
