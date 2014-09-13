//
//  DetailsViewCell.h
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressLabel.h"
#import "DetailsIcon.h"
#import "Project.h"

@interface DetailsViewCell : UITableViewCell
-(void)updateDetails:(Project *)args;
@end
