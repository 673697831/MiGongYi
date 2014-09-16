//
//  AboutMeTabButton.h
//  MiGongYi
//
//  Created by megil on 9/16/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutMeItemView : UIView
@property(nonatomic, weak) UIButton *myButton;
@property(nonatomic, weak) UIImageView *myImageView;
@property(nonatomic, weak) UILabel *myLabel;

- (void)initialize:(NSString *)imagePath
              text:(NSString *)text;

@end
