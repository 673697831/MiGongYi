//
//  MGYRiceBoxingDetailsTableViewCell.h
//  MiGongYi
//
//  Created by megil on 11/15/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYBoxingRecord.h"

@protocol MGYRiceBoxingDetailsTableViewCellDelegate <NSObject>

- (void)changeFollowMonster:(MGYMonster *)monster
           isSelectedStatus:(BOOL)isSelectedStatus;

@end

@interface MGYRiceBoxingDetailsTableViewCell : UITableViewCell

@property (nonatomic, weak) id<MGYRiceBoxingDetailsTableViewCellDelegate> cellDelegate;

- (void)setDetails:(MGYMonster *)monster;

+ (CGFloat)minHeight;

+ (CGFloat)hideHeight;

@end
