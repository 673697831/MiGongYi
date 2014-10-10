//
//  PersonalDetails.h
//  MiGongYi
//
//  Created by megil on 9/15/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

typedef NS_ENUM(NSInteger, MGYSexType) {
    MGYSexTypeUnknow = 0,
    MGYSexTypeMale = 1,
    MGYSexTypeFemale = 2,
};

@interface MGYPersonalDetails : MTLModel <MTLJSONSerializing>

@property(nonatomic, assign) NSInteger uid;
@property(nonatomic, assign) MGYSexType sex;
@property(nonatomic, copy) NSString *nickname;
@property(nonatomic, copy) NSString *passport;
@property(nonatomic, copy) NSString *avatar;

@end
