//
//  DetailsViewCell.h
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYDetailsIcon.h"
#import "MGYProject.h"

@interface MGYDetailsViewCell : UITableViewCell
-(void)updateDetails:(MGYProject *)args;
@end
