//
//  MGYProtocolMyDonate.h
//  MiGongYi
//
//  Created by megil on 12/4/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

#import "MGYShare.h"
#import "MGYProject.h"

typedef NS_ENUM(NSInteger, MGYAttendStatus) {
    MGYAttendStatusUnDo,
    MGYAttendStatusDone,
};

/**
 *  @"aboutItemDesc": @"about_item_desc",
 @"attendStatus": @"attend_status",
 @"joinMemberNum": @"join_member_num",
 @"myDonateProject": @"my_donate_project",
 @"myDonateProjectRice": @"my_donate_project_rice",
 @"myDonateRice": @"my_donate_rice",
 @"myRice": @"my_rice",
 @"progress": @"progress",
 @"projectId": @"project_id",
 @"riceTotal": @"rice_total",
 @"share": @"share",
 @"status": @"status",
 @"summary": @"summary",
 @"title": @"title",
 @"userLevel": @"user_level",
 */

@interface MGYProtocolMyDonate : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *aboutItemDesc;
@property (nonatomic, assign) MGYAttendStatus attendStatus;
@property (nonatomic, assign) NSInteger joinMemberNum;
@property (nonatomic, assign) NSInteger myDonateProject;
@property (nonatomic, assign) NSInteger myDonateProjectRice;
@property (nonatomic, assign) NSInteger myDonateRice;
@property (nonatomic, assign) NSInteger myRice;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) NSInteger projectId;
@property (nonatomic, assign) NSInteger riceTotal;
@property (nonatomic, strong) MGYShare *share;
@property (nonatomic, assign) MGYProjectStatus status;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger userLevel;

@end
