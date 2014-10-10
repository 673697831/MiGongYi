//
//  MGYProjectRecent.h
//  MiGongYi
//
//  Created by megil on 9/23/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

typedef NS_ENUM(NSInteger, MGYProjectRecentType) {
    MGYProjectRecentTypeNormal = 10,
    MGYProjectRecentTypeFinished = 11,
};

@interface MGYProjectRecent : MTLModel <MTLJSONSerializing>

@property(nonatomic, assign) NSInteger parentId;
@property(nonatomic, assign) NSInteger projectId;
@property(nonatomic, copy) NSString *summary;
@property(nonatomic, copy) NSString *coverImg;
@property(nonatomic, assign) NSInteger showTime;
@property(nonatomic, copy) NSString *readmoreUrl;
@property(nonatomic, assign) MGYProjectRecentType type;

@end
