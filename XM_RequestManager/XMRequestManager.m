//
//  XMRequestManager.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/18.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//  小明系列 - OC版本 - 网络请求封装库 - 对AFNetworking的封装

#import "XMRequestManager.h"

typedef enum : NSUInteger {
    GetMethod_XM,    //  get 请求
    PostMethod_XM,   // post 请求
    OtherMethod_XM,
} kRequestMethodType_XM;

@interface XMRequestManager()

/// 请求管理器
@property (nonatomic, strong) AFHTTPSessionManager          *myManager;
/// 不需要弹出错误提示的网络请求的数组 - (把不需要弹出错误提示的url放里面) - 后台设计不规范，把成功的请求的状态值设置成非0了。好的后台人员不会这么干。。。。
@property (nonatomic, strong) NSMutableArray                *notShowErrorTipUrlArr;

@end

@implementation XMRequestManager

- (instancetype)init {
    self = [super init];
    /// 初始化请求相关，只执行一次
    self.notShowErrorTipUrlArr = [NSMutableArray array];
    self.myManager = [AFHTTPSessionManager manager];
    // 允许接收的类型
    AFJSONResponseSerializer *myResponseSer = [AFJSONResponseSerializer serializer];
    [myResponseSer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil]];
    [self.myManager setResponseSerializer:myResponseSer];
    // 超时时间
    [self.myManager.requestSerializer setTimeoutInterval:40];
    // 策略
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.validatesDomainName = YES;
    self.myManager.securityPolicy = securityPolicy;
    
    /// 存储所有不需要弹出错误提示的请求
    [self.notShowErrorTipUrlArr addObject:kHasNewCourse]; // 小红点不弹
    [self.notShowErrorTipUrlArr addObject:EKHomeCustomizePath]; // 定制
    [self.notShowErrorTipUrlArr addObject:MyPracticeDetails]; // 我的练习
    
    return self;
}
/// 单利
+ (XMRequestManager *)shareManager {
    static XMRequestManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XMRequestManager alloc] init];
    });
    return instance;
}

/**
 统一 get 请求 小明网络请求系列
 
 @param urlStr url的子地址例如：@"getUserInfo" (里面会统一拼接根url)
 @param param NSDictionary 参数
 @param success 成功block
 @param failure 失败block
 */
+ (void)getWithUrl:(NSString *)urlStr params:(nullable NSDictionary *)params successBlock:(SuccessBlock_XM)success failureBlock:(FailureBlock_XM)failure {
    [XMRequestManager baseRequestMethodType:GetMethod_XM urlStr:urlStr params:params succsuccessBlockess:success failureBlock:failure];
}

/**
 统一 post 请求 小明网络请求系列
 
 @param urlStr url的子地址例如：@"getUserInfo" (里面会统一拼接根url)
 @param param NSDictionary 参数
 @param success 成功block
 @param failure 失败block
 */
+ (void)postWithUrl:(NSString *)urlStr params:(nullable NSDictionary *)params successBlock:(SuccessBlock_XM)success failureBlock:(FailureBlock_XM)failure {
    [XMRequestManager baseRequestMethodType:PostMethod_XM urlStr:urlStr params:params succsuccessBlockess:success failureBlock:failure];
}

/// 返回是否成功 0 是成功.
+ (int)getRequestStatus:(NSDictionary *)dict {
    NSString *statusStr = [NSString stringWithFormat:@"%@",dict[@"status"]];
    return [statusStr intValue];
}
/// 请求返回的msg
+ (NSString *)getRequestMsg:(NSDictionary *)dict {
    if (![dict[@"msg"] isKindOfClass:[NSString class]]) { // 非字符串
        return @"";
    }
    NSString *msgStr = [NSString stringWithFormat:@"%@",dict[@"msg"]];
    if ([NSString isEmptyString:msgStr]) {
        msgStr = @"操作失败";
    }
    return msgStr;
}


/**
 统一的Base请求，最终都会调用这个方法
 
 @param methodType 请求的方法 : get/post/等等
 @param urlStr url的子地址例如：@"getUserInfo" (里面会统一拼接根url)
 @param param NSDictionary 参数
 @param success 成功block
 @param failure 失败block
 */
+ (void)baseRequestMethodType:(kRequestMethodType_XM)methodType urlStr:(NSString *)urlStr params:(NSDictionary *)params succsuccessBlockess:(SuccessBlock_XM)success failureBlock:(FailureBlock_XM)failure {
    // 获取最终的url
    NSString *lastUrlStr = [NSString stringWithFormat:@"%@",urlStr];
    if (![lastUrlStr hasPrefix:kBaseUrl]) {
        lastUrlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,urlStr];
    }
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    /// 添加通用的参数
    int _t = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString *_st = [NSString stringWithFormat:@"%d",arc4random_uniform(899999) + 100000];
    NSString *tempStr = [NSString stringWithFormat:@"%@_%d",_st,_t];
    NSString *_si = [tempStr md5String];
    [mutableDict setObject:@(_t) forKey:@"_t"];
    [mutableDict setObject:_st forKey:@"_st"];
    [mutableDict setObject:_si forKey:@"_si"];
    
    //  ----------------------------------get 请求 ----------------------------------------
    if (methodType == GetMethod_XM) { // get 请求
        [[XMRequestManager shareManager].myManager GET:lastUrlStr parameters:mutableDict progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            /// 取消所有HUD
            [XMTool dismissHUD:0];
            XMLog(@"\n [%@] 请求的成功结果: %@ \n",urlStr, responseObject);
            if ([XMRequestManager getRequestStatus:responseObject] == -2) { // 需要重新登录
                [UserManager logoutAction];
                [kAlertVManager otherLoginAlertAction];
            }
            if (([XMRequestManager getRequestStatus:responseObject] != 0) && ([XMRequestManager getRequestStatus:responseObject] != -2) && ([XMRequestManager getRequestStatus:responseObject] != 10000)) { // 提示错误信息
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (![[XMRequestManager shareManager].notShowErrorTipUrlArr containsObject:urlStr]) {
                        /// 特殊处理不需要弹出的提示 --- 本项目特有的
                        NSString *tipS = [XMRequestManager getRequestMsg:responseObject];
                        if ([tipS containsString:@"没有评论"] || [tipS containsString:@"不存在相关数据"] || [tipS containsString:@"没有数据"] || [tipS containsString:@"Error"]) {
                            
                        } else {
                            [XMTool showTipHUD:[XMRequestManager getRequestMsg:responseObject]];
                        }
                    }
                });
            }
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            /// 取消所有HUD， 弹出失败HUD
            if (![[XMRequestManager shareManager].notShowErrorTipUrlArr containsObject:urlStr]) {
                [XMTool showTipHUD:kRequestFailureTipStr_XM];
            } else {
                [XMTool dismissHUD:0];
            }
            NSLog(@" [%@] 请求失败: error==%@\n",urlStr, error.localizedDescription);
            if (failure) {
                failure(error);
            }
        }];
    }
    //  ----------------------------------post 请求 ----------------------------------------
    if (methodType == PostMethod_XM) {
        [[XMRequestManager shareManager].myManager POST:lastUrlStr parameters:mutableDict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            /// 取消所有HUD
            [XMTool dismissHUD:0];
            XMLog(@"\n [%@] 请求的成功结果: %@ \n",urlStr, responseObject);
            if ([XMRequestManager getRequestStatus:responseObject] == -2) { // 需要重新登录
                [UserManager logoutAction];
                [kAlertVManager otherLoginAlertAction];
            }
            if (([XMRequestManager getRequestStatus:responseObject] != 0) && ([XMRequestManager getRequestStatus:responseObject] != -2) && ([XMRequestManager getRequestStatus:responseObject] != 10000)) { // 提示错误信息
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (![[XMRequestManager shareManager].notShowErrorTipUrlArr containsObject:urlStr]) {
                        [XMTool showTipHUD:[XMRequestManager getRequestMsg:responseObject]];
                    }
                });
            }
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            /// 取消所有HUD， 弹出失败HUD
            if (![[XMRequestManager shareManager].notShowErrorTipUrlArr containsObject:urlStr]) {
                [XMTool showTipHUD:kRequestFailureTipStr_XM];
            } else {
                [XMTool dismissHUD:0];
            }
            NSLog(@" [%@] 请求失败: error==%@\n",urlStr, error.localizedDescription);
            if (failure) {
                failure(error);
            }
        }];
    }
}


@end
