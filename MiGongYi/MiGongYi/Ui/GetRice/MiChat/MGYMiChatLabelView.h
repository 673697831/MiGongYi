//
//  MGYMiChatButtonView.h
//  MiGongYi
//
//  Created by megil on 9/30/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYMiChatProgressView.h"
#import "MGYMiChatRecord.h"
//#import "MGYMiChatTableViewCell.h"
//
//@class MGYMiZhiTableViewCell;

typedef NS_ENUM(NSInteger, MGYMiChatPos) {
    MGYMiChatPosUnknow,
    MGYMiChatPosProgressView,
    MGYMiChatPosAddImageView,
    MGYMiChatPosNameLabel,
    MGYMiChatPosWarningImageView,
    MGYMiChatPosNextImageView,
    MGYMiChatPosSubView1,
    MGYMiChatPossubView3,
};

@interface MGYMiChatLabelView : UIView

- (void)reset:(MGYMiChatRecord *)miChatRecord
         type:(MGYMiChatProgressViewType)type;
- (MGYMiChatPos)getTouchView:(CGPoint)point;

@end
