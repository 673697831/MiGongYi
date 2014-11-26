//
//  MGYRiceBoxingDetailsTableViewCell.h
//  MiGongYi
//
//  Created by megil on 11/15/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYBoxingRecord.h"

@interface MGYRiceBoxingDetailsTableViewCell : UITableViewCell

- (void)setDetails:(MGYMonster *)monster;

+ (CGFloat)minHeight;

+ (CGFloat)hideHeight;

@end
