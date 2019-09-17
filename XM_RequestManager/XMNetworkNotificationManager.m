//
//  XMNetworkNotificationManager.m
//  艺库
//
//  Created by zhangmingwei on 2019/9/17.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMNetworkNotificationManager.h"

@implementation XMNetworkNotificationManager

- (instancetype)init {
    self = [super init];
    /// 初始化请求相关，只执行一次
    /// 初始化监听网络方法
    [self allNetworkChangeNotificationAction];
    return self;
}
/// 单利
+ (XMNetworkNotificationManager *)shareManager {
    static XMNetworkNotificationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XMNetworkNotificationManager alloc] init];
    });
    return instance;
}

/// 网络变化监听 ---- 全局就一个地方
- (void)allNetworkChangeNotificationAction {
    AFNetworkReachabilityManager *networkJudge = [AFNetworkReachabilityManager sharedManager];
    [networkJudge startMonitoring];
    [networkJudge setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable || status == AFNetworkReachabilityStatusUnknown) { // 没网络
            // 无网通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kNoNetworkNotification" object:nil];
            // 所有下载任务暂停
//            [YCDownloadManager pauseAllDownloadTask];
            self.netwokStatus_XM = noNetwork_XM;
            XMLog(@"网络通知-XM---无网");
        } else {
            if (status == AFNetworkReachabilityStatusReachableViaWiFi) { // WiFi
                self.netwokStatus_XM = wifi_XM;
                XMLog(@"网络通知-XM---wifi");
            } else if (status == AFNetworkReachabilityStatusReachableViaWWAN) { // 蜂窝网
                XMLog(@"网络通知-XM---蜂窝网");
                self.netwokStatus_XM = cellular_XM;
                // 所有下载任务暂停
//                if (UserManager.shared.isAllowDownloadNotWifi == NO) { // 不允许非WiFi下载
//                    [YCDownloadManager pauseAllDownloadTask];
//                }
            } else {
                XMLog(@"网络通知-XM---其他"); // 一般不会出现
            }
            // 有网通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kYesNetworkNotification" object:nil];
        }
    }];
}


@end
