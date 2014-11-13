//
//  MGYDetailsViewController.h
//  MiGongYi
//
//  Created by megil on 9/18/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYSubViewController.h"

@interface MGYDetailsViewController : MGYBaseViewController<UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithProjectId:(NSInteger) projectId;

@end
