//
//  Project.h
//  MiGongYi
//
//  Created by megil on 9/9/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

typedef NS_ENUM(NSInteger, MGYProjectType) {
    MGYProjectTypeItem = 1,
    MGYProjectTypeChildren = 2,
};

typedef NS_ENUM(NSInteger, MGYProjectStatus) {
    MGYProjectStatusFinished = 0,
    MGYProjectStatusNormal = 1,
};

@interface MGYProject : MTLModel <MTLJSONSerializing>
@property(nonatomic, assign) MGYProjectType type;
@property(nonatomic, assign) NSInteger projectId;
@property(nonatomic, copy) NSString *coverImg;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, assign) NSInteger riceDonate;
@property(nonatomic, assign) NSInteger progress;
@property(nonatomic, assign) NSInteger favNum;
@property(nonatomic, assign) NSInteger joinMemberNum;
@property(nonatomic, assign) MGYProjectStatus status;
@end
