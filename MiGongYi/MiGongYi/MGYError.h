

#pragma mark - 米聊聊请求返回错误

typedef NS_ENUM(NSInteger, MGYMiChatError) {
    MGYMiChatErrorGainFailure = 9001,//获得米失败
    MGYMiChatErrorGainFull = 9002,//本周获得米粒次数满了 每周6次
};