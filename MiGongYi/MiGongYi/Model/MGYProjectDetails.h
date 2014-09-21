//
//  MGYProjectDetails.h
//  MiGongYi
//
//  Created by megil on 9/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

#import "MGYProject.h"

@interface MGYProjectDetails : MTLModel <MTLJSONSerializing>

@property(nonatomic, assign) NSInteger projectId;
@property(nonatomic, copy) NSString *detailImg;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;
@property(nonatomic, copy) NSString *summary;
@property(nonatomic, assign) NSString *riceDonate;
@property(nonatomic, assign) NSInteger progress;
@property(nonatomic, assign) MGYProjectType type;
@property(nonatomic, assign) NSInteger favNum;
@property(nonatomic, assign) NSInteger joinMemberNum;
@property(nonatomic, assign) NSInteger helpMemberNum;
@property(nonatomic, copy) NSDictionary *donor;
@property(nonatomic, copy) NSDictionary *recipient;
@property(nonatomic, copy) NSDictionary *resource;
@property(nonatomic, assign) NSInteger status;
@property(nonatomic, copy) NSString *readmoreUrl;
@property(nonatomic, assign) NSInteger fav;

@end
