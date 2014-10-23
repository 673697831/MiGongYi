//
//  SDTableViewCell.m
//  Ricedonate
//
//  Created by megil on 10/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "SDTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"
#import "UIImageView+WebCache.h"
#import "MGYNetworking.h"

@interface SDTableViewCell ()

@property(nonatomic, weak)UIImageView *myimageView;

@end

@implementation SDTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *myimageView = [UIImageView new];
        [self addSubview:myimageView];
        self.myimageView = myimageView;
        
        [myimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self);
            make.width.equalTo(self.mas_height);
            make.left.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

- (void)reset:(NSString *)url
{
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url]
//                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    }];
    //[self.imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    //[self.myimageView sd_setImageWithURL:[NSURL URLWithString:url]];
    [self.myimageView mgy_setImageWithURL:[NSURL URLWithString:url]];
}

@end
