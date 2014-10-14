//
//  MGYMiChatRecord.h
//  MiGongYi
//
//  Created by megil on 10/9/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
#import <AddressBook/AddressBook.h>

@interface MGYMiChatRecord : MTLModel <MTLJSONSerializing>

@property(nonatomic, copy) NSString *personName;
@property(nonatomic, assign) NSInteger totalTimes;
@property(nonatomic, assign) NSInteger currentTimes;
@property(nonatomic, strong) NSArray *phoneList;
@property(nonatomic, assign) BOOL completed;

@end
