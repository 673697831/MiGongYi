//
//  MGYMiChatPickerView.h
//  MiGongYi
//
//  Created by megil on 10/6/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGYMiChatPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

typedef void (^FinishCallback)(NSInteger);
@property(nonatomic, copy) FinishCallback finishCallback;

- (instancetype)initWithArray:(NSArray *)array;

@end
