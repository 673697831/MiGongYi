//
//  Project.h
//  MiGongYi
//
//  Created by megil on 9/9/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

typedef NS_ENUM(NSInteger, ProjectType) {
    ItemType = 1,
    ChildrenType = 2,
};
@interface Project : MTLModel <MTLJSONSerializing>
@property(nonatomic, assign) ProjectType type;
@property(nonatomic, assign) NSInteger projectId;
//@property(nonatomic, assign) NSInteger project_id;
@property(nonatomic, copy) NSString *coverImg;
//@property(nonatomic, copy) NSString *cover_img;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, assign) NSInteger riceDonate;
//@property(nonatomic, assign) NSInteger rice_donate;
@property(nonatomic, assign) NSInteger progress;
@property(nonatomic, assign) NSInteger favNum;
//@property(nonatomic, assign) NSInteger fav_num;
@property(nonatomic, assign) NSInteger joinMemberNum;
//@property(nonatomic, assign) NSInteger join_member_num;
@property(nonatomic, assign) NSInteger status;
@end
