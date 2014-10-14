//
//  DetailsIcon.h
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MGYDetailsIconFontColorType) {
    MGYDetailsIconFontColorType1,
    MGYDetailsIconFontColorType2,
};

@interface MGYDetailsIcon : UIView

@property(nonatomic, weak) UILabel *numLabel;
@property(nonatomic, weak) UIImageView *imageView;
@property(nonatomic, weak) UILabel *itemLabel;


- (instancetype)initWithType:(MGYDetailsIconFontColorType)type;
- (void)resetDetails:(NSString *)num
                path:(NSString *)path
                text:(NSString *)text;

@end
