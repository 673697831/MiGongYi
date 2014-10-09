//
//  MGYMiChatMonsterTableViewCell.h
//  MiGongYi
//
//  Created by megil on 10/9/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MGYMiChatMonsterState) {
    MGYMiChatMonsterStateGray,
    MGYMiChatMonsterStateHighlight,
};

@interface MGYMiChatMonsterTableViewCell : UITableViewCell

- (void)resetMonsterState:(NSArray *)array;

@end
