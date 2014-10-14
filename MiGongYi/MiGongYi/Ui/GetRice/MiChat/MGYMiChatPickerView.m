//
//  MGYMiChatPickerView.m
//  MiGongYi
//
//  Created by megil on 10/6/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiChatPickerView.h"
#import "Masonry.h"

@interface MGYMiChatPickerView ()

@property(nonatomic, weak) UIView *view1;
@property(nonatomic, weak) UIButton *buttonCansel;
@property(nonatomic, weak) UIButton *buttonDone;
@property(nonatomic, weak) UIPickerView *picker;
@property(nonatomic, weak) UIView *view2;
@property(nonatomic, weak) UIView *view3;
@property(nonatomic, strong) NSArray *array;
@property(nonatomic, assign) NSInteger selectedTimes;

@end

@implementation MGYMiChatPickerView

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        
        UIView *view2 = [UIView new];
        view2.backgroundColor = [UIColor whiteColor];
        [self addSubview:view2];
        self.view2 = view2;
        
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.mas_equalTo(200);
        }];
        
        UIPickerView *picker = [UIPickerView new];
        picker.delegate = self;
        picker.dataSource = self;
        [self addSubview:picker];
        self.picker = picker;
        
        [picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.mas_equalTo(200);
        }];
        
        UIView *view1 = [UIView new];
        view1.backgroundColor = [UIColor blackColor];
        [self addSubview:view1];
        self.view1 = view1;
        
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.picker.mas_top);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        
        UIButton *buttonCansel = [UIButton new];
        [buttonCansel addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        buttonCansel.tag = 0;
        [buttonCansel setTitle:NSLocalizedString(@"Cansel", @"Cansel")
                      forState:UIControlStateNormal];
        [buttonCansel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:buttonCansel];
        self.buttonCansel = buttonCansel;
        
        [buttonCansel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(view1);
            make.width.mas_equalTo(80);
            make.bottom.equalTo(view1);
            make.left.equalTo(view1);
        }];
        
        UIButton *buttonDone = [UIButton new];
        [buttonDone addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        buttonDone.tag = 1;
        [buttonDone setTitle:NSLocalizedString(@"Done", @"Done")
                    forState:UIControlStateNormal];
        [buttonDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:buttonDone];
        self.buttonDone = buttonDone;
        
        [buttonDone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(view1);
            make.width.mas_equalTo(80);
            make.bottom.equalTo(view1);
            make.right.equalTo(view1);
        }];
        
        UIView *view3 = [UIView new];
        [self addSubview:view3];
        view3.backgroundColor = [UIColor whiteColor];
        view3.alpha = 0.8;
        self.view3 = view3;
        
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view1.mas_top);
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
        }];
        
        self.array = array;
        self.selectedTimes = 1;
    }
    return self;
}

- (void)clickEvent:(id)sender
{
    if (self.finishCallback && self.buttonDone == sender) {
        self.finishCallback(self.selectedTimes);
    }
    else
    {
        self.finishCallback(0);
    }
    
    self.finishCallback = nil;
}

#pragma mark - pickerView delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedTimes = [[self.array objectAtIndex:row] integerValue];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.array.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@", [self.array objectAtIndex:row]];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
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
