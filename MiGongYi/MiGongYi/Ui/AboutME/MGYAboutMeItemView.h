//
//  AboutMeTabButton.h
//  MiGongYi
//
//  Created by megil on 9/16/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGYAboutMeItemView : UIView
@property(nonatomic, weak) UIButton *myButton;
@property(nonatomic, weak) UIImageView *myImageView;
@property(nonatomic, weak) UILabel *myLabel;

- (instancetype)initWithFrame:(CGRect)frame
              normalImagePath:(NSString *)normalImagePath
            selectedImagePath:(NSString *)selectedImagePath
                        title:(NSString *)title;

- (void)setSelect:(BOOL)isSelected;

@end
