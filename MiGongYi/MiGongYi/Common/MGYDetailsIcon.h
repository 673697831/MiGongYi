//
//  DetailsIcon.h
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGYDetailsIcon : UIView

@property(nonatomic, weak) UILabel *numLabel;
@property(nonatomic, weak) UIImageView *imageView;
@property(nonatomic, weak) UILabel *itemLabel;

//- (void)resetArgs:(NSDictionary *)args;
- (void)resetDetails:(NSString *)num
                path:(NSString *)path
                text:(NSString *)text;

- (void)resetFontColor:(NSString *)numberColor
             itemColor:(NSString *)itemColor;
@end
