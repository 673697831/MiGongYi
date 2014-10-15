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
#import "MGYShare.h"

@interface MGYProjectDetailsDonorOrRecipient : MTLModel <MTLJSONSerializing>

@property(nonatomic, copy) NSString *showImg;
@property(nonatomic, copy) NSString *title;

@end

@interface MGYProjectDetailsResource : MTLModel <MTLJSONSerializing>

@property(nonatomic, copy) NSString *resourceName;
@property(nonatomic, assign) NSInteger resourceNum;

@end

@interface MGYProjectDetails : MTLModel <MTLJSONSerializing>

@property(nonatomic, assign) NSInteger projectId;
@property(nonatomic, copy) NSString *detailImg;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;
@property(nonatomic, copy) NSString *summary;
@property(nonatomic, assign) NSInteger riceDonate;
@property(nonatomic, assign) NSInteger progress;
@property(nonatomic, assign) MGYProjectType type;
@property(nonatomic, assign) NSInteger favNum;
@property(nonatomic, assign) NSInteger joinMemberNum;
@property(nonatomic, assign) NSInteger helpMemberNum;
@property(nonatomic, strong) MGYProjectDetailsDonorOrRecipient *donor;
@property(nonatomic, strong) MGYProjectDetailsDonorOrRecipient *recipient;
@property(nonatomic, strong) MGYProjectDetailsResource *resource;
@property(nonatomic, assign) NSInteger status;
@property(nonatomic, copy) NSString *readmoreUrl;
@property(nonatomic, assign) NSInteger fav;
@property(nonatomic, assign) NSInteger commentExist;
@property(nonatomic, strong) MGYShare *share;

@end


