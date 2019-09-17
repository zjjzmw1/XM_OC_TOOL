//
//  XMNetworkNotificationManager.h
//  艺库
//
//  Created by zhangmingwei on 2019/9/17.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 网络的状态 - 无网、流量、WiFi
typedef enum : NSUInteger {
    noNetwork_XM,    // 无网
    cellular_XM,     // 蜂窝网
    wifi_XM,         // WiFi
} NetworkStatus_XM;

/// 网络状态的监听的管理器 - 网络变化监听
@interface XMNetworkNotificationManager : NSObject

/// 单利
+ (XMNetworkNotificationManager *)shareManager;

/// 网络状态 noNetwork_XM: 无网   cellular_XM：流量   wifi_XM：WiFi
@property (nonatomic, assign) NetworkStatus_XM       netwokStatus_XM;

@end

NS_ASSUME_NONNULL_END
