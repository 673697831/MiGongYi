//
//  MGYProgramItemViewController.h
//  MiGongYi
//
//  Created by megil on 9/13/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYBaseViewController.h"

@interface MGYProgramItemViewController : MGYBaseViewController<UITableViewDelegate, UITableViewDataSource>

- (void)resetData:(NSArray *)array reset:(BOOL)reset;

@end
