//
//  MGYMiChatTableViewCell.h
//  MiGongYi
//
//  Created by megil on 9/30/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "MGYMiChatRecord.h"
#import "MGYMiChatLabelView.h"

@protocol MGYMiChatTableViewCellDelegate <NSObject>

- (void)openABPeoplePicker:(NSIndexPath *)indexPath;
- (void)closeABPeoplePicker:(void (^)(NSInteger totalTimes))finishCallback;
- (void)deletePeople:(NSIndexPath *)indexPath;
- (void)callPeople:(NSIndexPath *)indexPath;
- (void)resetOtherCellPosition:(NSIndexPath *)indexPath;

@end

typedef NS_ENUM(NSInteger, MGYMiChatCellState) {
    MGYMiChatStateCellLeft,
    MGYMiChatStateCellRight,
};

@interface MGYMiChatTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property(nonatomic, weak) id<MGYMiChatTableViewCellDelegate> cellDelegate;
@property(nonatomic, strong) NSIndexPath *indexPath;

- (void)scrollEnabled:(BOOL)enabled;
- (void)resetPosition;
- (void)reset:(NSIndexPath *)indexPath
       record:(MGYMiChatRecord *)record;

@end
