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
#import "MGYMiChatRecord.h"
#import "MGYMiChatMonsterTableViewCell.h"
#import "DataManager.h"
#import "MGYError.h"
#import "MGYMiChatMonsterView.h"

@interface MGYMiChatViewController ()
{
    NSMutableArray *_cellArray;
    NSMutableArray *_miChatRecordList;
}

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, weak) MGYMiChatPickerView *pickView;
@property(nonatomic, weak) UIWebView *callWebview;

@end

@implementation MGYMiChatViewController

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
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                          style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[MGYMiChatTableViewCell class] forCellReuseIdentifier:@"ChatTableView Cell"];
    [tableView registerClass:[MGYMiChatMonsterTableViewCell class]
      forCellReuseIdentifier:@"MonsterTableView Cell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    MGYMiChatPickerView *pickView = [[MGYMiChatPickerView alloc] initWithArray:@[@(1),@(2),@(3),@(4), @(5), @(6)]];
    pickView.hidden = YES;
    [self.view addSubview:pickView];
    self.pickView = pickView;
    
    UIWebView *callWebview = [UIWebView new];
    [self.view addSubview:callWebview];
    self.callWebview = callWebview;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    //UIPanGestureRecognizer 拖动
    
    
    [pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _miChatRecordList = [NSMutableArray arrayWithArray:[DataManager shareInstance].miChatRecordList];
    
}

#pragma mark - MGYMiChatTableViewCellDelegate
- (void)openABPeoplePicker:(NSIndexPath *)indexPath
{
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    ABPeoplePickerNavigationController *picker = [ABPeoplePickerNavigationController new];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)closeABPeoplePicker:(void (^)(NSInteger))finishCallback
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.pickView.finishCallback = finishCallback;
    if (finishCallback) {
        self.pickView.hidden = NO;
        //[self.view bringSubviewToFront:self.pickView];
    }
}

- (void)deletePeople:(NSIndexPath *)indexPath
{
    MGYMiChatRecord *miChatRecord = _miChatRecordList[indexPath.row];
    miChatRecord.personName = @"";
    miChatRecord.phoneList = @[];
    miChatRecord.completed = NO;
    miChatRecord.currentTimes = 0;
    miChatRecord.totalTimes = 0;
    [[DataManager shareInstance] saveMiChatRecord:_miChatRecordList];
    [self.tableView reloadData];
}

- (void)callPeople:(NSIndexPath *)indexPath
{
    NSURL *telURL =[NSURL URLWithString:@"tel:10086"];
    [self.callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    MGYMiChatRecord *miChatRecord = _miChatRecordList[indexPath.row];
    miChatRecord.currentTimes ++;
    if (![DataManager shareInstance].canGainRiceFromMiChat) {
        miChatRecord.completed = YES;
    }
    if ([DataManager shareInstance].canGainRiceFromMiChat && miChatRecord.totalTimes <= miChatRecord.currentTimes && !miChatRecord.completed) {
        [[DataManager shareInstance] gainRiceFromMiChat:^(NSInteger rice) {
            NSString *str= [NSString stringWithFormat:@"你获得了%d大米", rice];
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:str
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alter show];
            miChatRecord.completed = YES;
            [[DataManager shareInstance] saveMiChatRecord:_miChatRecordList];
            [self.tableView reloadData];
                                        }
                                               failure:^(NSError *error) {
                                                   if (error.code == MGYMiChatErrorGainFull) {
                                                       miChatRecord.completed = YES;
                                                   }
                                                   [[DataManager shareInstance] saveMiChatRecord:_miChatRecordList];
                                                   [self.tableView reloadData];
                                               }];
    }else
    {
        [[DataManager shareInstance] saveMiChatRecord:_miChatRecordList];
        [self.tableView reloadData];
    }
    
//    [self.tableView insertRowsAtIndexPaths:@[indexPath]
//                          withRowAnimation:UITableViewRowAnimationBottom];
    
}

- (void)resetOtherCellPosition:(NSIndexPath *)indexPath
{
    for (MGYMiChatTableViewCell *cell in [self.tableView visibleCells]) {
        if (indexPath != cell.indexPath) {
            [cell resetPosition];
        }
        
    }
}

- (NSArray *)monsterState
{
    NSInteger completedNum = 0;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _miChatRecordList.count; i ++) {
        MGYMiChatRecord *record = _miChatRecordList[i];
        if (record.currentTimes >= record.totalTimes && record.totalTimes != 0) {
            completedNum ++;
            [array addObject:@(MGYMiChatMonsterStateHighlight)];
        }
        else
        {
            [array addObject:@(MGYMiChatMonsterStateGray)];
        }
    }
    if (completedNum == _miChatRecordList.count) {
        [array addObject:@(MGYMiChatMonsterStateHighlight)];
    }else
    {
        [array addObject:@(MGYMiChatMonsterStateGray)];
    }
    return array;
}

#pragma mark - peoplePicker delegate
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    ABMultiValueRef phoneNumberProperty = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSArray* phoneNumberArray = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phoneNumberProperty));
    NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    NSString *lastName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    NSString *name = @"";
    if (lastName) {
        name = [name stringByAppendingString:lastName];
    }
    if (firstName) {
        name = [name stringByAppendingString:firstName];
    }
    
    self.pickView.finishCallback = ^(NSInteger totalTimes) {
        if (totalTimes && person && phoneNumberArray &&name && totalTimes > 0) {
            NSDictionary *dic = @{@"personName": name, @"totalTimes": @(totalTimes), @"currentTimes": @0, @"phoneList": phoneNumberArray, @"hasWarning":@NO};
            MGYMiChatRecord *miChatRecord = [MTLJSONAdapter modelOfClass:[MGYMiChatRecord class]
                                                      fromJSONDictionary:dic
                                                                   error:nil];
            [_miChatRecordList replaceObjectAtIndex:self.tableView.indexPathForSelectedRow.row
                                         withObject:miChatRecord];
            [[DataManager shareInstance] saveMiChatRecord:_miChatRecordList];
            [self.tableView reloadData];
            
        }
        self.pickView.hidden = YES;
    };
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.pickView.hidden = NO;
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

#pragma mark - tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        MGYMiChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatTableView Cell" forIndexPath:indexPath];
        if (!cell.cellDelegate) {
            cell.cellDelegate = self;
            [_cellArray addObject:cell];
        }
        MGYMiChatRecord *miChatRecord = _miChatRecordList[indexPath.row];
        [cell reset:indexPath
             record:miChatRecord];
        return cell;
    }
    else
    {
        MGYMiChatMonsterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MonsterTableView Cell" forIndexPath:indexPath];
        [cell resetMonsterState:@[@(0), @(1), @(0), @(1), @(0), @(1), @(0)]];
        return cell;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num;
    if (section == 0) {
        num = 6;
    }else
    {
        num = 1;
    }
    return num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heihgt;
    if (indexPath.section == 0) {
        heihgt = 59;
    }else
    {
        heihgt = 180;
    }
    return heihgt;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MGYMiChatMonsterView *view = [MGYMiChatMonsterView new];
    NSArray *array = [self monsterState];
    [view resetMonsterState:array];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 180;
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
