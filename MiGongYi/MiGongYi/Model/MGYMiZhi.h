//
//  MGYMiZhi.h
//  MiGongYi
//
//  Created by megil on 9/29/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface MGYMiZhi : MTLModel <MTLJSONSerializing>

@property(nonatomic, assign) NSInteger dailyId;
@property(nonatomic, copy) NSString *dailyTitle;
@property(nonatomic, copy) NSString *dailyImg;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *shareUrl;

@end
