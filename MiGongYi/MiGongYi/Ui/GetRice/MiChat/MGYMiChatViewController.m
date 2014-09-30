//
//  MiChatViewController.m
//  MiGongYi
//
//  Created by megil on 9/29/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiChatViewController.h"

@interface MGYMiChatViewController ()

@end

@implementation MGYMiChatViewController

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    
    [picker setPeoplePickerDelegate:self];
    
    [self presentViewController:picker animated:YES completion:NULL];
    
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
