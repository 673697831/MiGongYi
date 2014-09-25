//
//  AboutMeTableViewCell.h
//  MiGongYi
//
//  Created by megil on 9/20/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGYAboutMeTableViewCellDelegate <NSObject>

- (void)click:(NSInteger)type;

@end

@interface MGYAboutMeTableViewCell : UITableViewCell

@property(nonatomic, strong) id<MGYAboutMeTableViewCellDelegate> clickDelegate;

@end
