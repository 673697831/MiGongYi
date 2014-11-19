//
//  MGYRiceMoveLevel.h
//  MiGongYi
//
//  Created by megil on 11/18/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface MGYRiceMoveLevelRecord :MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *levelString;
@property (nonatomic, assign) NSInteger storyIndex;
@property (nonatomic, assign) NSInteger nodeIndex;
@property (nonatomic, assign) long long timeSp;

@end
