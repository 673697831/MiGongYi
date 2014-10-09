//
//  MGYMiChatTableViewCell.m
//  MiGongYi
//
//  Created by megil on 9/30/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiChatTableViewCell.h"
#import "MGYMiChatLabelView.h"
#import "Masonry.h"

@interface MGYMiChatTableViewCell ()

@property(nonatomic, weak) UIScrollView *cellScrollView;
@property(nonatomic, weak) MGYMiChatLabelView *lableView;
@property(nonatomic, assign) MGYMiChatCellState cellState;
@property(nonatomic, weak) UIWebView *callWebview;

@end

@implementation MGYMiChatTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self initializer];
    }
    return self;
}

- (void)initializer
{
    //UIScrollView *cellScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), _height)];
    
//    MGYMiChatButtonView *rightButtonView = [MGYMiChatButtonView new];
//    rightButtonView.backgroundColor = [UIColor yellowColor];
//    [self addSubview:rightButtonView];
//    self.rightButtonView = rightButtonView;
    
    MGYMiChatLabelView *lableView = [MGYMiChatLabelView new];
    [self addSubview:lableView];
    self.lableView = lableView;
    
    UIScrollView *cellScrollView = [UIScrollView new];
    cellScrollView.alwaysBounceVertical = YES;
    cellScrollView.pagingEnabled = YES;
    cellScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * 2, self.bounds.size.height);
    cellScrollView.contentOffset = CGPointMake(0, 0);
    cellScrollView.delegate = self;
    cellScrollView.scrollEnabled = NO;
    cellScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:cellScrollView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewPressed:)];
    [cellScrollView addGestureRecognizer:tapGestureRecognizer];
    self.cellScrollView = cellScrollView;
    
    
    
    UIWebView *callWebview = [UIWebView new];
    [self addSubview:callWebview];
    self.callWebview = callWebview;
    
    self.cellState = MGYMiChatStateCellLeft;
    
    [self setup];
}

- (void)setup
{
    [self.cellScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.lableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cellScrollView);
        make.centerY.equalTo(self.cellScrollView);
        make.height.equalTo(self.cellScrollView);
        make.width.equalTo(self).with.multipliedBy(2.0);
    }];
}

- (void)scrollViewPressed:(id)sender {
    if (!self.miChatRecord) {
        ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
        picker.peoplePickerDelegate = self;
        [self.cellDelegate openABPeoplePicker:picker];
        return;
    }
    
    CGPoint point = [sender locationInView:self];
    MGYMiChatPos chatPos = [self.lableView getTouchView:point
                                                       state:self.cellState];
    
    if (chatPos != MGYMiChatPosNextImageView && self.cellState == MGYMiChatStateCellLeft) {
        NSURL *telURL =[NSURL URLWithString:@"tel:10086"];
        [self.callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        return;
    }
    
    if (chatPos == MGYMiChatPosWarningImageView) {
        return;
    }
    
    if (chatPos == MGYMiChatPosNextImageView) {
        [self.cellScrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:YES];
        self.cellState = MGYMiChatStateCellRight;
        return;
    }
    
    if (chatPos == MGYMiChatPosSubView1) {
        [self.cellScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.cellState = MGYMiChatStateCellLeft;
        return;
    }
    
    if (chatPos == MGYMiChatPossubView3) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"你点击了删除" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
        self.miChatRecord = nil;
        self.miChatRecord = nil;
        [self.lableView reset:@"名字"];
        self.cellScrollView.scrollEnabled = NO;
        [self.cellScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.cellState = MGYMiChatStateCellLeft;
        return;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame = self.lableView.frame;
    frame.origin.x =  -scrollView.contentOffset.x;
    self.lableView.frame = frame;

    if (self.cellState == MGYMiChatStateCellRight) {
        [self.cellDelegate resetOtherCellPosition:self];
    }
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (targetContentOffset -> x == self.bounds.size.width) {
        //[self.cellDelegate resetOtherCellPosition:self];
        self.cellState = MGYMiChatStateCellRight;
    }else if(targetContentOffset -> x == 0)
    {
        self.cellState = MGYMiChatStateCellLeft;
    }
}

- (void)scrollEnabled:(BOOL)enabled
{
    self.cellScrollView.scrollEnabled = enabled;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    //[self dismissViewControllerAnimated:YES completion:NULL];
    [self.cellDelegate closeABPeoplePicker:nil];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    ABMultiValueRef phoneNumberProperty = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSArray* phoneNumberArray = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phoneNumberProperty));
    for(int index = 0; index< [phoneNumberArray count]; index++){
        //NSString *phoneNumber = [phoneNumberArray objectAtIndex:index];
        //NSLog(@"%@", phoneNumber);
    }
    NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    NSString *lastName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    NSString *name = @"";
    if (lastName) {
        name = [name stringByAppendingString:lastName];
    }
    if (firstName) {
        name = [name stringByAppendingString:firstName];
    }
    if (name) {

    }
    
    [self.cellDelegate closeABPeoplePicker:^(NSInteger totalTimes) {
            //NSLog(@"qqqqqqqq %@ %d", self.person, totalTimes);
        if (totalTimes && person && phoneNumberArray &&name && totalTimes > 0) {
            self.miChatRecord = [MTLJSONAdapter modelOfClass:[MGYMiChatRecord class] fromJSONDictionary:@{@"personName":name,@"totalTimes":@(totalTimes), @"currentTimes":@0, @"phoneList":phoneNumberArray} error:nil];
            [self.cellDelegate finishCallback];
            
            [self.lableView reset:name];
            self.cellScrollView.scrollEnabled = YES;
        }
    }];
    //[self dismissViewControllerAnimated:YES completion:NULL];
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

- (void)resetPosition
{
    [self.cellScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.cellState = MGYMiChatStateCellLeft;
}


@end
