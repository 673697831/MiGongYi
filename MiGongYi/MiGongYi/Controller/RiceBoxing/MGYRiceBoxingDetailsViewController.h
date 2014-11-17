//
//  MGYRiceBoxingDetailsViewController.h
//  MiGongYi
//
//  Created by megil on 11/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYSubViewController.h"

@interface MGYRiceBoxingDetailsViewController : MGYSubViewController<UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithMonsterId:(NSInteger)monsterId;

@end
