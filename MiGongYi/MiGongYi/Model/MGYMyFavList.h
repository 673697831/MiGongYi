//
//  MGYMyFavList.h
//  MiGongYi
//
//  Created by megil on 9/26/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface MGYMyFavList : MTLModel <MTLJSONSerializing>

@property(nonatomic, assign) NSInteger count;
@property(nonatomic, strong) NSArray *rs;

@end
