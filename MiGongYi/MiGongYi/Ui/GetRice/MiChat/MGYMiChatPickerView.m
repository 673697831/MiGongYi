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

@property(nonatomic, weak) UILabel *label1;
@property(nonatomic, weak) UIButton *buttonCansel;
@property(nonatomic, weak) UIButton *buttonDone;
@property(nonatomic, weak) UIPickerView *picker;
@property(nonatomic, weak) UILabel *label2;
@property(nonatomic, weak) UILabel *label3;
@property(nonatomic, strong) NSArray *array;

@end

@implementation MGYMiChatPickerView

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        
        UILabel *label2 = [UILabel new];
        label2.backgroundColor = [UIColor whiteColor];
        [self addSubview:label2];
        self.label2 = label2;
        
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
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
        
        UILabel *label1 = [UILabel new];
        label1.backgroundColor = [UIColor blackColor];
        [self addSubview:label1];
        self.label1 = label1;
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.picker.mas_top);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        
        UIButton *buttonCansel = [UIButton new];
        [buttonCansel addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [buttonCansel setTitle:@"Cansel" forState:UIControlStateNormal];
        [buttonCansel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:buttonCansel];
        self.buttonCansel = buttonCansel;
        
        [buttonCansel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(label1);
            make.width.mas_equalTo(80);
            make.bottom.equalTo(label1);
            make.left.equalTo(label1);
        }];
        
        UIButton *buttonDone = [UIButton new];
        [buttonDone addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [buttonDone setTitle:@"Done" forState:UIControlStateNormal];
        [buttonDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:buttonDone];
        self.buttonDone = buttonDone;
        
        [buttonDone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(label1);
            make.width.mas_equalTo(80);
            make.bottom.equalTo(label1);
            make.right.equalTo(label1);
        }];
        
        UILabel *label3 = [UILabel new];
        [self addSubview:label3];
        label3.backgroundColor = [UIColor whiteColor];
        label3.alpha = 0.8;
        self.label3 = label3;
        
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.label1.mas_top);
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
        }];
        
        self.array = array;
        
    }
    return self;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.array.count;
    //return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //return @([self.array objectAtIndex:row]);
    return [NSString stringWithFormat:@"%@", [self.array objectAtIndex:row]];
    //return @"1";
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void)clickEvent:(id)sender
{
    self.hidden = YES;
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
