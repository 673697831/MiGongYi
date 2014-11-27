#define CustomErrorDomain @"MGYError"

#pragma mark - 米聊聊请求返回错误

typedef NS_ENUM(NSInteger, MGYMiChatError) {
    MGYMiChatErrorGainFailure = 9001,//获得米失败
    MGYMiChatErrorGainFull = 9002,//本周获得米粒次数满了 每周6次
};

#pragma mark - 留守儿童和公益项目返回错误
typedef NS_ENUM(NSInteger, MGYListError) {
    MGYMiListErrorEmpty = 1,//返回空
};

#pragma mark - 米粒流水
typedef NS_ENUM(NSInteger, MGYUserRiceflowError) {
    MGYUserRiceflowErrorParameter = 6,//参数错误
    MGYUserRiceflowErrorUserNotExist = 1001,//用户不存在
};

#pragma mark - 

#define MGYRiceBoxingErrorDomain @"MGYRiceBoxingError"
typedef NS_ENUM(NSInteger, MGYRiceBoxingError) {
    MGYRiceBoxingErrorRiceNull//没有剩余次数 结算不成功 怪会复活
};
