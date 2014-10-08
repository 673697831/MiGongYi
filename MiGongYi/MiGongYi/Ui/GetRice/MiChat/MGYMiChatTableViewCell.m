//
//  MGYMiChatTableViewCell.m
//  MiGongYi
//
//  Created by megil on 9/30/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiChatTableViewCell.h"
#import "MGYMiChatButtonView.h"
#import "Masonry.h"

@interface MGYMiChatTableViewCell ()

@property(nonatomic, weak) UIScrollView *cellScrollView;
@property(nonatomic, weak) MGYMiChatButtonView *leftButtonView;
//@property(nonatomic, weak) MGYMiChatButtonView *rightButtonView;
@property(nonatomic, assign) MGYMiChatCellState cellState;
@property(nonatomic, assign) ABRecordRef person;
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
    MGYMiChatButtonView *leftButtonView = [MGYMiChatButtonView new];
    //leftButtonView.backgroundColor = [UIColor blueColor];
    [self addSubview:leftButtonView];
    self.leftButtonView = leftButtonView;
    
//    MGYMiChatButtonView *rightButtonView = [MGYMiChatButtonView new];
//    rightButtonView.backgroundColor = [UIColor yellowColor];
//    [self addSubview:rightButtonView];
//    self.rightButtonView = rightButtonView;

    
    UIScrollView *cellScrollView = [UIScrollView new];
    cellScrollView.alwaysBounceVertical = YES;
    cellScrollView.pagingEnabled = YES;
    //cellScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) + [self utilityButtonsPadding], _height);
    cellScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * 2, self.bounds.size.height);
    //cellScrollView.backgroundColor = [UIColor blueColor];
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
    
    [self.leftButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cellScrollView);
        make.centerY.equalTo(self.cellScrollView);
        make.height.equalTo(self.cellScrollView);
        //make.width.equalTo(self);
        make.width.mas_equalTo(self.bounds.size.width * 2);
    }];
    
//    [self.rightButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.leftButtonView.mas_right);
//        make.centerY.equalTo(self.cellScrollView);
//        make.height.equalTo(self);
//        make.width.equalTo(self);
//    }];
}

- (void)scrollViewPressed:(id)sender {
//    if(_cellState == kCellStateCenter) {
//        // Selection hack
//        if ([self.containingTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
//            NSIndexPath *cellIndexPath = [_containingTableView indexPathForCell:self];
//            [self.containingTableView.delegate tableView:_containingTableView didSelectRowAtIndexPath:cellIndexPath];
//        }
//        // Highlight hack
//        if (!self.highlighted) {
//            self.scrollViewButtonViewLeft.hidden = YES;
//            self.scrollViewButtonViewRight.hidden = YES;
//            NSTimer *endHighlightTimer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(timerEndCellHighlight:) userInfo:nil repeats:NO];
//            [[NSRunLoop currentRunLoop] addTimer:endHighlightTimer forMode:NSRunLoopCommonModes];
//            [self setHighlighted:YES];
//        }
//    } else {
//        // Scroll back to center
//        [self hideUtilityButtonsAnimated:YES];
//    }
    
    CGPoint point = [sender locationInView:self];
    NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
    
    if (self.cellState == MGYMiChatStateCellRight) {
        if (point.x < 2 * 44) {
            [self.cellScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            self.cellState = MGYMiChatStateCellLeft;
        }else if (point.x < self.bounds.size.width - 2 * 44)
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"你点击了一日三次" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alter show];
        }else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"你点击了删除" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alter show];
            self.person = nil;
            [self.leftButtonView reset:@"名字"];
            self.cellScrollView.scrollEnabled = NO;
            [self.cellScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            self.cellState = MGYMiChatStateCellLeft;
        }
        
    }
    else
    {
        if (point.x > self.bounds.size.width - 2 * 44) {
            if (!self.cellScrollView.scrollEnabled) {
                return;
            }
            [self.cellScrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:YES];
            self.cellState = MGYMiChatStateCellRight;
        }else if (point.x > 2 * 44)
        {
//            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"你点击了联系人名字" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alter show];
            if (!self.person) {
                ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
                
                picker.peoplePickerDelegate = self;
                
                [self.cellDelegate openABPeoplePicker:picker];
            }
            else
            {
                NSURL *telURL =[NSURL URLWithString:@"tel:10086"];
                [self.callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
                //记得添加到view上
            }
            
            //self.cellScrollView.scrollEnabled = YES;
        }
        else
        {
//            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"你点击了头像" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alter show];
            if(self.person)
            {
                [self.cellDelegate clickHeadView];
            }

        }
        
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame = self.leftButtonView.frame;
    frame.origin.x =  -scrollView.contentOffset.x;
    self.leftButtonView.frame = frame;

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
    [self.cellDelegate closeABPeoplePicker];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    ABMultiValueRef phoneNumberProperty = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSArray* phoneNumberArray = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phoneNumberProperty));
    for(int index = 0; index< [phoneNumberArray count]; index++){
        //NSString *phoneNumber = [phoneNumberArray objectAtIndex:index];
        //NSLog(@"%@", phoneNumber);
    }
    self.person = person;
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
       [self.leftButtonView reset:name];
        self.cellScrollView.scrollEnabled = YES;
    }
    
    [self.cellDelegate closeABPeoplePicker];
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
