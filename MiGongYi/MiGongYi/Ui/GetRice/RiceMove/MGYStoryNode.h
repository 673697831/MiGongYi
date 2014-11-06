//
//  MGYStoryNode.h
//  MiGongYi
//
//  Created by megil on 10/28/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

typedef NS_ENUM(NSInteger, MGYStoryNodeType) {
    MGYStoryNodeTypeHead = 0,
    MGYStoryNodeTypeAction = 1,
    MGYStoryNodeTypeTrail = 2,
    MGYStoryNodeTypeNormalBrach = 3,
    MGYStoryNodeTypeMiZhiBrach = 4,
    MGYStoryNodeTypeBoxingBrach = 5,
};

typedef NS_ENUM(NSInteger, MGYStoryBuffType) {
    MGYStoryBuffTypeShoes = 0,
    MGYStoryBuffTypeBear = 1,
    MGYStoryBuffTypeJewel = 2,
    MGYStoryBuffTypeMonster = 3,
};

typedef NS_ENUM(NSInteger, MGYStoryBuffStateType) {
    MGYStoryBuffStateTypeClose = 0,
    MGYStoryBuffStateTypeOpen = 1,
};

/**
 *  弹出提示
 */
typedef NS_ENUM(NSInteger, MGYStoryTipsType)
{
    /**
     *  木有图片的
     */
    MGYStoryTipsType1,
    /**
     *  有图片的
     */
    MGYStoryTipsType2,
};
/**
 *  关卡 1-3 1-2 1-1
 */
@interface MGYStoryLevel :MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) NSInteger mapIndex;
@property (nonatomic, assign) NSInteger nodeIndex;

@end

@interface MGYStoryBranch : MTLModel <MTLJSONSerializing>
/**
 *  identifier:节点
    mapName:地图名称 没的话默认当前地图
    title:弹出选项 对应content 默认没有
    content:弹出提示,默认没有,不弹
 */
@property(nonatomic, assign) NSInteger identifier;
@property(nonatomic, copy) NSString *mapName;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *content;

@end

@interface MGYStoryTips : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) MGYStoryTipsType tipsType;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *imagePath;

@end

@interface MGYStoryBuff : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) MGYStoryBuffType buffType;
@property (nonatomic, assign) MGYStoryBuffStateType buffState;
@property (nonatomic, copy) NSString *buffImagePath;

@end

@interface MGYStoryNode : MTLModel <MTLJSONSerializing>

//@property (nonatomic, copy) NSString *storyName;
@property (nonatomic, copy) NSString *storyContent;
@property (nonatomic, strong) NSArray *branch;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) MGYStoryNodeType nodeType;
@property (nonatomic, assign) NSInteger progress;
@property (nonatomic, strong) NSArray *arrayBuff;
@property (nonatomic, assign) NSInteger riceNum;
@property (nonatomic, strong) MGYStoryLevel *nextLevel;
@property (nonatomic, strong) MGYStoryTips *storyTips;

@end
