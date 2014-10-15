//
//  MGYMiZhiShare.h
//  MiGongYi
//
//  Created by megil on 10/11/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface MGYShare : MTLModel <MTLJSONSerializing>

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *summary;
@property(nonatomic, copy) NSString *imgUrl;
@property(nonatomic, copy) NSString *url;

@end
