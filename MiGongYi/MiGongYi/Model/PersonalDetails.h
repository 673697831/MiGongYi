//
//  PersonalDetails.h
//  MiGongYi
//
//  Created by megil on 9/15/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

typedef NS_ENUM(NSInteger, SexType) {
    Unknow = 0,
    Male = 1,
    Female = 2,
};
@interface PersonalDetails : MTLModel <MTLJSONSerializing>
@property(nonatomic, assign) NSInteger uid;
@property(nonatomic, assign) SexType sex;
@property(nonatomic, copy) NSString *nickname;
@property(nonatomic, copy) NSString *passport;
@property(nonatomic, copy) NSString *avatar;
@end
