//
//  Project.h
//  MiGongYi
//
//  Created by megil on 9/9/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject
@property(nonatomic, assign) int type;
@property(nonatomic, assign) int project_id;
@property(nonatomic, strong) NSString *cover_img;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) int rice_donate;
@property(nonatomic, assign) int progress;
@property(nonatomic, assign) int fay_num;
@property(nonatomic, assign) int join_member_num;
@property(nonatomic, assign) int status;

-(id)initWithKeys:(int)type ProjectId:(int)project_id CoverImg:(NSString *)cover_img Title:(NSString *)title RiceDonate:(int)rice_donate Progress:(int)progress FayNum:(int)fay_num JoinMemberNum:(int)join_member_num Status:(int)status;
@end
