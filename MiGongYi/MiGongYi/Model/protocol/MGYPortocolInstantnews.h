//
//  MGYPortocolInstantnews.h
//  MiGongYi
//
//  Created by megil on 12/4/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

typedef NS_ENUM(NSInteger, MGYInstantnewsCommentType) {
    MGYInstantnewsCommentTypeUser = 1,
    MGYInstantnewsCommentTypeSystem = 2,
    MGYInstantnewsCommentTypeDonateSuccess = 3,
};

@interface MGYPortocolInstantnewsComment : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) long long time;
@property (nonatomic, assign) MGYInstantnewsCommentType type;

@end

@interface MGYPortocolInstantnews : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) long long lastGetTime;
@property (nonatomic, strong) NSArray *rs;


@end
