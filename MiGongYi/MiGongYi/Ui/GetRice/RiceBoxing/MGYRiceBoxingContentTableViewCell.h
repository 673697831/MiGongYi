//
//  MGYRiceBoxingContentTableViewCell.h
//  MiGongYi
//
//  Created by megil on 11/24/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYBoxingRecord.h"
#import "MGYGetRiceDisappearDelegate.h"

@interface MGYRiceBoxingContentTableViewCell : UITableViewCell

@property (nonatomic, weak) id<MGYGetRiceCellDelegate> disappearDelegate;

- (void)setDetails:(MGYMonster *)monster;

+ (CGFloat)minHeight;

+ (CGFloat)heightForDailyContent;

+ (CGFloat)widthForDailyContent;

@end
