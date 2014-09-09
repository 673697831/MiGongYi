//
//  Project.m
//  MiGongYi
//
//  Created by megil on 9/9/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "Project.h"

@implementation Project
-(id)initWithKeys:(int)type ProjectId:(int)project_id CoverImg:(NSString *)cover_img Title:(NSString *)title RiceDonate:(int)rice_donate Progress:(int)progress FayNum:(int)fay_num JoinMemberNum:(int)join_member_num Status:(int)status
{
    self = [super init];
    self.type = type;
    self.project_id = project_id;
    self.cover_img = cover_img;
    self.title = title;
    self.rice_donate = rice_donate;
    self.progress = progress;
    self.fay_num = fay_num;
    self.join_member_num = join_member_num;
    self.status = status;
    return self;
}
@end
