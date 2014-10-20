//
//  AboutMeTableViewCell.h
//  MiGongYi
//
//  Created by megil on 9/20/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MGYAboutMeSourceType) {
    MGYAboutMeSourceTypeRiceFlow,
    MGYAboutMeSourceTypeFriendList,
    MGYAboutMeSourceTypeFavList,
};

@protocol MGYAboutMeTableViewCellDelegate <NSObject>

- (void)click:(MGYAboutMeSourceType)type;

@end

@interface MGYAboutMeTableViewCell : UITableViewCell

@property(nonatomic, strong) id<MGYAboutMeTableViewCellDelegate> clickDelegate;

- (void)resetNum:(NSInteger) riceNumber;

@end
