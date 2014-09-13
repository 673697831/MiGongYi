//
//  DetailsIcon.h
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsIcon : UILabel
@property(nonatomic, strong) UILabel *numLabel;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *itemLabel;

- (id)initWithFrame:(CGRect)frame Args:(NSDictionary *)args;
@end
