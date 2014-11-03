//
//  MGYRiceMoveDetailsViewController.h
//  MiGongYi
//
//  Created by megil on 11/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYSubViewController.h"

@interface MGYRiceMoveDetailsViewController : MGYSubViewController<UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithMap:(NSInteger)index;

@end
