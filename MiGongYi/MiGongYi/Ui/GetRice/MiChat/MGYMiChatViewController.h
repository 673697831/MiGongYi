//
//  MiChatViewController.h
//  MiGongYi
//
//  Created by megil on 9/29/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "MGYSubViewController.h"
#import "MGYMiChatTableViewCell.h"
#import "MGYMiChatPhoneListView.h"

@interface MGYMiChatViewController : MGYSubViewController<UITableViewDelegate, UITableViewDataSource, ABPeoplePickerNavigationControllerDelegate,MGYMiChatTableViewCellDelegate, MGYMiChatPhoneListViewDelegate>

@end
