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

@protocol MGYMiChatTableViewCellDelegate <NSObject>

- (void)openABPeoplePicker:(ABPeoplePickerNavigationController *) picker;
- (void)closeABPeoplePicker;
- (void)resetOtherCellPosition:(id)cell;
- (void)clickHeadView;

@end

typedef NS_ENUM(NSInteger, MGYMiChatCellState) {
    MGYMiChatStateCellLeft,
    MGYMiChatStateCellRight,
};

@interface MGYMiChatTableViewCell : UITableViewCell<UIScrollViewDelegate, ABPeoplePickerNavigationControllerDelegate>

@property(nonatomic, weak) id<MGYMiChatTableViewCellDelegate> cellDelegate;

- (void)scrollEnabled:(BOOL)enabled;
- (void)resetPosition;

@end
