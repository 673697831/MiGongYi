//
//  MGYRiceMoveProgressView.m
//  MiGongYi
//
//  Created by megil on 10/31/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveProgressView.h"
#import "Masonry.h"
#import "MGYRiceMoveProgressSubView.h"

@interface MGYRiceMoveProgressView ()

@property (nonatomic, weak) MGYRiceMoveProgressSubView *progressView1;
@property (nonatomic, weak) UIImageView *imageView1;
@property (nonatomic, weak) MGYRiceMoveProgressSubView *progressView2;
@property (nonatomic, weak) UIImageView *imageView2;
@property (nonatomic, weak) MGYRiceMoveProgressSubView *progressView3;
@property (nonatomic, weak) UIImageView *imageView3;
@property (nonatomic, weak) MGYRiceMoveProgressSubView *progressView4;
@property (nonatomic, weak) UIImageView *imageView4;
@property (nonatomic, strong) NSArray *normalImageArray;
@property (nonatomic, strong) NSArray *fullImageArray;

@end

@implementation MGYRiceMoveProgressView


- (instancetype)init
{
    self = [super init];
    if (self) {
        _normalImageArray = @[@"page_craw1_normal", @"page_craw2_normal", @"page_craw3_normal",@"page_door_closed"];
        _fullImageArray = @[@"page_craw1_full", @"page_craw2_full", @"page_craw3_full", @"page_door_open"];
        for (int i = 1; i <= 4; i ++) {
            MGYRiceMoveProgressSubView *view = [[MGYRiceMoveProgressSubView alloc] initWithProgress:0];
            UIImageView *imageView = [UIImageView new];
            [imageView setImage:[UIImage imageNamed:_normalImageArray[i - 1]]];
            [self addSubview:view];
            [self addSubview:imageView];
            [self setValue:view
                    forKey:[NSString stringWithFormat:@"progressView%d", i]];
            [self setValue:imageView
                    forKey:[NSString stringWithFormat:@"imageView%d", i]];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.centerY.equalTo(self).with.multipliedBy((4-i)/2.0);
            }];
        }
        
        [self.progressView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.width.mas_equalTo(4);
            make.centerX.equalTo(self);
            make.top.equalTo(self.imageView1.mas_bottom);
        }];
        
        [self.progressView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.imageView1.mas_top);
            make.width.mas_equalTo(4);
            make.centerX.equalTo(self);
            make.top.equalTo(self.imageView2.mas_bottom);
        }];
        
        [self.progressView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.imageView2.mas_top);
            make.width.mas_equalTo(4);
            make.centerX.equalTo(self);
            make.top.equalTo(self.imageView3.mas_bottom);
        }];
        
        [self.progressView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.imageView3.mas_top);
            make.width.mas_equalTo(4);
            make.centerX.equalTo(self);
            make.top.equalTo(self.imageView4.mas_bottom);
        }];
//        for (int i = 1; i <= 4; i ++) {
//            UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"imageView%d", i]];
//            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerX.equalTo(self);
//                make.centerY.equalTo(self.mas_height).with.multipliedBy(i/4.0);
//            }];
//        }
    }
    
    return self;
}

- (void)resetProgress:(NSArray *)array
{
    for (int i =0; i < array.count; i ++) {
        MGYRiceMoveProgressSubView *view =
        [self valueForKey:[NSString stringWithFormat:@"progressView%d", i + 1]];
        [view resetProgress:[array[i] floatValue]];
        UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"imageView%d", i + 1]];
        if ([array[i] integerValue] == 1) {
            [imageView setImage:[UIImage imageNamed:_fullImageArray[i]]];
        }else
        {
            [imageView setImage:[UIImage imageNamed:_normalImageArray[i]]];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
