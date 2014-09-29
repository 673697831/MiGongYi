//
//  MGYMiZhiTableViewCell.h
//  MiGongYi
//
//  Created by megil on 9/29/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYMiZhi.h"

@protocol MGYMiZhiTableViewCellDelegate <NSObject>

- (void)updateWebViewHeight:(CGFloat)height;

@end

@interface MGYMiZhiTableViewCell : UITableViewCell<UIWebViewDelegate>

@property(nonatomic, strong) id<MGYMiZhiTableViewCellDelegate> clickDelegate;

- (void)hideContent:(BOOL)isHide;
- (void)reset:(MGYMiZhi *)miZhi;

@end
