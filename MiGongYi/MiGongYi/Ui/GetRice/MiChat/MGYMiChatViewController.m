//
//  MiChatViewController.m
//  MiGongYi
//
//  Created by megil on 9/29/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiChatViewController.h"
#import "Masonry.h"
#import "MGYMiChatPickerView.h"
#import "MGYMiChatDetailsViewController.h"

@interface MGYMiChatViewController ()
{
    NSMutableArray *_cellArray;
}

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, weak) MGYMiChatTableViewCell *selectCell;
@property(nonatomic, weak) MGYMiChatPickerView *pickView;

@end

@implementation MGYMiChatViewController

- (void)openABPeoplePicker:(ABPeoplePickerNavigationController *)picker
{
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)closeABPeoplePicker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.pickView.hidden = NO;
}

- (void)resetOtherCellPosition:(id)selectCell
{
    for (MGYMiChatTableViewCell *cell in _cellArray) {
        if (selectCell != cell) {
            [cell resetPosition];
        }
        
    }
}

- (void)clickHeadView
{
    //self.pickView.hidden = NO;
    MGYMiChatDetailsViewController *detailsViewController = [MGYMiChatDetailsViewController new];
    [self.navigationController pushViewController:detailsViewController animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGYMiChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatTableView Cell" forIndexPath:indexPath];
    if (!cell.cellDelegate) {
        cell.cellDelegate = self;
        [_cellArray addObject:cell];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
//    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
//        if (granted) {
//            //查询所有
//           // NSLog(@"iiiiiiiiiii %@", CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook)));
//            NSArray *array = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
//            for (int i = 0; i < array.count; i ++) {
//                ABRecordRef thisPerson = CFBridgingRetain(array[i]);
//                ABMultiValueRef phoneNumberProperty = ABRecordCopyValue(thisPerson, kABPersonPhoneProperty);
//                NSArray* phoneNumberArray = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phoneNumberProperty));
//                //NSLog(@"%@", [phoneNumberArray objectAtIndex:0]);
////                for(int index = 0; index< [phoneNumberArray count]; index++){
////                    
////                    NSString *phoneNumber = [phoneNumberArray objectAtIndex:index];
////                    NSLog(@"%@", phoneNumber);
////                }
//            }
//        }
//    });
    // Do any additional setup after loading the view.
    _cellArray = [NSMutableArray array];
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[MGYMiChatTableViewCell class] forCellReuseIdentifier:@"ChatTableView Cell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    MGYMiChatPickerView *pickView = [[MGYMiChatPickerView alloc] initWithArray:@[@(1),@(2), @(3)]];
    pickView.hidden = YES;
    [self.view addSubview:pickView];
    self.pickView = pickView;
    
    [pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
