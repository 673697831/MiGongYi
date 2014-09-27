//
//  MGYRiceFlow.h
//  MiGongYi
//
//  Created by megil on 9/26/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface MGYRiceFlow : MTLModel <MTLJSONSerializing>

@property(nonatomic, assign) NSInteger riceRemain;
@property(nonatomic, strong) NSArray *rs;

@end
