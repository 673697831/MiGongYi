//
//  MGYMiChatPhoneListView.h
//  MiGongYi
//
//  Created by megil on 10/16/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGYMiChatPhoneListViewDelegate <NSObject>

- (void)selectNumber:(NSString *)number;

@end

@interface MGYMiChatPhoneListView : UIView

@property(nonatomic, weak) id<MGYMiChatPhoneListViewDelegate> myDelegate;

- (instancetype)initPhoneList:(NSArray *)phoneList;

@end
