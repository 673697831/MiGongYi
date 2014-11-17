//
//  MGYRiceMoveTableViewController.h
//  MiGongYi
//
//  Created by megil on 11/17/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYSubViewController.h"
#import "MGYRiceMoveContentTableViewCell.h"
#import "MGYRiceMoveSelectTableViewCell.h"

typedef NS_ENUM(NSInteger, MGYRiceMoveTableViewType) {
    MGYRiceMoveTableViewTypeContent,
    MGYRiceMoveTableViewTypeSelect,
};

@interface MGYRiceMoveTableViewController : MGYSubViewController<UITableViewDataSource, UITableViewDelegate, MGYRiceMoveTableViewCellDelegate>

- (instancetype)initWithSelectCallback:(MGYStorySelectCallback)selectCallback
             contentViewSelectCallback:(MGYRiceMoveContentViewSelectCallback)contentViewSelectCallback
       contentViewDidDisappearCallback:(MGYRiceMoveContentViewDidDisappearCallback)contentViewDidDisappearCallback;

@end
