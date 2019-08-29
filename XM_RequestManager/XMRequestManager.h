//
//  XMRequestManager.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/18.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//  小明系列 - OC版本 - 网络请求封装库 - 对AFNetworking的封装

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

/// 发送成功的回调block
typedef void (^SuccessBlock_XM)(NSDictionary *returnData);
/// 发送失败的回调block
typedef void(^FailureBlock_XM)(NSError *error);

/// 网络请求封装库 - 对AFNetworking的封装 - 小明系列OC版本
@interface XMRequestManager : AFURLSessionManager

/// 单利
+ (XMRequestManager *)shareManager;

/**
 统一 get 请求 小明网络请求系列

 @param urlStr url的子地址例如：@"getUserInfo" (里面会统一拼接根url)
 @param param NSDictionary 参数
 @param success 成功block
 @param failure 失败block
 */
+ (void)getWithUrl:(NSString *)urlStr params:(nullable NSDictionary *)params successBlock:(SuccessBlock_XM)success failureBlock:(FailureBlock_XM)failure;

/**
 统一 post 请求 小明网络请求系列
 
 @param urlStr url的子地址例如：@"getUserInfo" (里面会统一拼接根url)
 @param param NSDictionary 参数
 @param success 成功block
 @param failure 失败block
 */
+ (void)postWithUrl:(NSString *)urlStr params:(nullable NSDictionary *)params successBlock:(SuccessBlock_XM)success failureBlock:(FailureBlock_XM)failure;

/// 返回是否成功 0 是成功.
+ (int)getRequestStatus:(NSDictionary *)dict;
/// 请求返回的msg
+ (NSString *)getRequestMsg:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
