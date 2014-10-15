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

typedef NS_ENUM(NSInteger, MGYDetailsIconType) {
    MGYDetailsIconTypeRice,
    MGYDetailsIconTypePeople,
    MGYDetailsIconTypeFav,
};

@interface MGYDetailsIcon : UIView

@property(nonatomic, weak) UILabel *numLabel;
@property(nonatomic, weak) UIImageView *imageView;
@property(nonatomic, weak) UILabel *itemLabel;


- (instancetype)initWithType:(MGYDetailsIconType)type
                   colorType:(MGYDetailsIconFontColorType)colorType;
- (void)reset:(NSString *)num;

@end
