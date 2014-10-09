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

@interface MGYMiChatViewController ()
{
    NSMutableArray *_cellArray;
}

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, weak) MGYMiChatPickerView *pickView;

@end

@implementation MGYMiChatViewController

- (void)openABPeoplePicker:(ABPeoplePickerNavigationController *)picker
{
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)closeABPeoplePicker:(void (^)(NSInteger))finishCallback
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.pickView.finishCallback = finishCallback;
    if (finishCallback) {
        self.pickView.hidden = NO;
    }
    
}

- (void)resetOtherCellPosition:(id)selectCell
{
    for (MGYMiChatTableViewCell *cell in _cellArray) {
        if (selectCell != cell) {
            [cell resetPosition];
        }
        
    }
}

- (void)finishCallback
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _cellArray.count; i ++) {
        MGYMiChatTableViewCell *cell = _cellArray[i];
        NSData *udObject;
        if (cell.miChatRecord) {
            udObject = [NSKeyedArchiver archivedDataWithRootObject:cell.miChatRecord];
        }
        else
        {
            //MGYMiChatRecord *emptyRecord = [MTLJSONAdapter modelOfClass:[MGYMiChatRecord class] fromJSONDictionary:nil error:nil];
            NSNull *emptyRecord = [NSNull null];
            udObject = [NSKeyedArchiver archivedDataWithRootObject:emptyRecord];

        }
        [array addObject:udObject];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"MiChatRecords"];
    NSArray *readArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"MiChatRecords"];
    //NSLog(@"readArray ===== %@", readArray);
    for (int i = 0; i < readArray.count; i ++) {
        //MGYMiChatRecord *record = [NSKeyedUnarchiver unarchiveObjectWithData:readArray[i]];
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
    
    if (indexPath.section == 0) {
        MGYMiChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatTableView Cell" forIndexPath:indexPath];
        if (!cell.cellDelegate) {
            cell.cellDelegate = self;
            [_cellArray addObject:cell];
        }
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
    return 2;
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
    [tableView registerClass:[MGYMiChatMonsterTableViewCell class]
      forCellReuseIdentifier:@"MonsterTableView Cell"];
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
