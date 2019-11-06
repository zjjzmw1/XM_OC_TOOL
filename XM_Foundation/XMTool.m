//
//  XMTool.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMTool.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "NSString+XMValid.h"
#import "XMTabBarVC.h"
#import "XMToolMacro.h"
#import "Reachability.h"

#include <sys/param.h>      // 手机空闲空间的方法
#include <sys/mount.h>      // 手机空闲空间的方法

@interface XMTool()

/// 准备消失页面
@property (nonatomic, assign) BOOL  isReadyDissmiss;
/// XMTool单例 - 个别方法用的属性了，所有添加单例
+ (XMTool *)shareManager;

@end

@implementation XMTool

+ (XMTool *)shareManager {
    static XMTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XMTool alloc] init];
    });
    return instance;
}

/// 返回联网状态： 0：未联网，1：4G  2: wifi
+ (int)getCurrentNetworkInt {
    //得到3G网络装填
    NetworkStatus gprs = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus];
    if (gprs == ReachableViaWiFi) { // WiFi
        return 2;
    }
    if (gprs == ReachableViaWWAN) { // 4G
        return 1;
    }
    return 0;
}

/// 一直loading动画的HUD -- 背景可以点击
+ (void)showHUD {
    [XMTool shareManager].isReadyDissmiss = NO;
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}
/// 一直loading动画的HUD -- 背景不可点击
+ (void)showHUDInWindow:(NSString *)loadingStr {
    [XMTool shareManager].isReadyDissmiss = NO;
    [SVProgressHUD showWithStatus:loadingStr];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}
/// 弹出hud提示。 1.5s后自动消失
+ (void)showTipHUD:(NSString *)tipStr {
    [XMTool shareManager].isReadyDissmiss = YES;
    [SVProgressHUD dismissWithDelay:0];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@""]];
    if ([XMTool getCurrentNetworkInt] == 0) { // 未联网
        [SVProgressHUD showErrorWithStatus:kNetworkErrorTipStr_XM];
    } else if (![NSString isEmptyString:tipStr]) {
        [SVProgressHUD showErrorWithStatus:tipStr];
    }
    [SVProgressHUD dismissWithDelay:1.5];
}
/// 隐藏HUD 0 就是立刻消失，  秒数
+ (void)dismissHUD:(NSTimeInterval)time {
    if ([XMTool shareManager].isReadyDissmiss == NO) {
        [XMTool shareManager].isReadyDissmiss = YES;
        [SVProgressHUD dismissWithDelay:time];
    } else {
        /// isReadyDissmiss : YES 证明调用过延迟消失的方法了。,所以这里就不执行消失了。
    }
}

#pragma mark - 获取当前屏幕显示的viewcontroller
+ (nullable UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [XMTool getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [XMTool getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        // 根视图为UINavigationController
        currentVC = [XMTool getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

/// 移除掉navigationController栈中某一个viewController
+ (void)removeVC:(UIViewController *)currentVC {
    NSMutableArray *naviVCsArr = [[NSMutableArray alloc]initWithArray:[XMTool getCurrentVC].navigationController.viewControllers];
    for (UIViewController *vc in naviVCsArr) {
        if ([vc isKindOfClass:[currentVC class]]) {
            [naviVCsArr removeObject:vc];
            break;
        }
    }
    [XMTool getCurrentVC].navigationController.viewControllers = naviVCsArr;
}

/// 保证一个方法在0.5秒内不能重复调用
+ (BOOL)repeatCallAction:(NSString *)funcName {
    static NSDate *now = nil;
    static NSString *funcStr = nil;
    if (![funcStr isEqualToString:funcName]) { // 如果调用的方法不是一个，就重写给now赋值
        now = nil;
    }
    if (!now) {
        now = [NSDate dateWithTimeIntervalSinceNow:-0.6]; // 第一次赋值当然是不能被拦截的。
    }
    if ([[NSDate dateWithTimeIntervalSinceNow:-0.5] compare:now] != kCFCompareGreaterThan) { // 比之前保存的时候小就拦截
        NSLog(@"XMTool: 频繁调用%@被拦截了",funcName);
        return YES; // 0.5秒内不能重复调用这个方法
    }
    now = [NSDate date];
    funcStr = funcName;
    return NO;
}
/// 保证一个方法在 1 秒内不能重复调用 -- 倒计时的时候用
+ (BOOL)repeatCallActionInOneSecond:(NSString *)funcName {
    static NSDate *now = nil;
    static NSString *funcStr = nil;
    if (![funcStr isEqualToString:funcName]) { // 如果调用的方法不是一个，就重写给now赋值
        now = nil;
    }
    if (!now) {
        now = [NSDate dateWithTimeIntervalSinceNow:-1.1]; // 第一次赋值当然是不能被拦截的。
    }
    if ([[NSDate dateWithTimeIntervalSinceNow:-0.9] compare:now] != kCFCompareGreaterThan) { // 比之前保存的时候小就拦截
//        NSLog(@"XMTool: 小于1秒就调用%@被拦截了",funcName);
        return YES; // 1秒内不能重复调用这个方法
    }
    now = [NSDate date];
    funcStr = funcName;
    return NO;
}

/// 设置tabBar显示指定控制器
+ (void)showTabbarVCIndex:(NSInteger)index {
    [[XMTabBarVC defaultManager] showControllerIndex:index];
}

///  显示tabbar的数字角标  badge: 所要显示数字
+ (void)showBadgeMark:(NSInteger)badge index:(NSInteger)index {
    [[XMTabBarVC defaultManager] showBadgeMark:badge index:index];
}

/// 展示某个vc的小红点
+ (void)showPointMarkIndex:(NSInteger)index {
    [[XMTabBarVC defaultManager] showPointMarkIndex:index];
}

/// 隐藏指定位置角标 -- 不管是小红点还是数字都隐藏
+ (void)hideMarkIndex:(NSInteger)index {
    [[XMTabBarVC defaultManager] hideMarkIndex:index];
}

#pragma mark ==========================获取空间大小相关 BEGIN===================================
/// 获取本地视频的缓存大小。---- 这里可以根据自己项目存储的位置选择修改。
+ (float )getLocalVideoCacheSize_XM {
    // paths.lastObject 是总目录/var/mobile/Containers/Data/Application/03BE2564-B162-436F-9634-6DB75BAEDCFD/Documents
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *lastPath = [NSString stringWithFormat:@"%@/YCDownload/video",[paths lastObject]];
    return [XMTool getFolderSizeAtPath_XM:lastPath];
}
/// 获取手机剩余空间大小单位是：bytes
+ (float)getMyPhoneFreeSize_XM {
    // 本方法需要头文件：
//    #include <sys/param.h>
//    #include <sys/mount.h>
    struct statfs buf;
    float freespace = -1;
    if(statfs("/var", &buf) >= 0) {
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    if (freespace < 0) {
        freespace = 0;
    }
    return freespace;
}

/// 获取某个文件夹的大小 单位：bytes
+ (float)getFolderSizeAtPath_XM:(NSString *)folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [XMTool getFileSizeAtPath_XM:fileAbsolutePath];
    }
    return folderSize;
}
/// 获取单个文件的大小 单位：bytes
+ (long long)getFileSizeAtPath_XM:(NSString*)filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
/// 根据 byte的大小，返回 多少GB /MB/KB/B
+ (NSString *)getFileSizeStringFromBytes_XM:(uint64_t)byteSize {
    float gb = (1024 * 1024 * 1024);
    float mb = (1024 * 1024);
    float kb = 1024;
    
    if (gb <= byteSize) {
        return [NSString stringWithFormat:@"%@GB", [XMTool getNumberStrFromDouble_XM:(double)byteSize / gb]];
    }
    if (mb <= byteSize) {
        return [NSString stringWithFormat:@"%@MB", [XMTool getNumberStrFromDouble_XM:(double)byteSize / mb]];
    }
    if (kb <= byteSize) {
        return [NSString stringWithFormat:@"%@KB", [XMTool getNumberStrFromDouble_XM:(double)byteSize / kb]];
    }
    return [NSString stringWithFormat:@"%lluB", byteSize];
}
/// 数字转换为字符串
+ (NSString *)getNumberStrFromDouble_XM:(const double)num {
    NSInteger section = round((num - (NSInteger)num) * 100);
    if (section % 10) {
        return [NSString stringWithFormat:@"%.2f", num];
    }
    if (section > 0) {
        return [NSString stringWithFormat:@"%.1f", num];
    }
    return [NSString stringWithFormat:@"%.0f", num];
}
#pragma mark ==========================获取空间大小相关 END===================================


// 清除网页缓存 WKWebsiteDataStore
+ (void)clearWKWebViewCache_XM {
    NSSet *websiteDataTypes = [NSSet setWithArray:@[
                                                     WKWebsiteDataTypeDiskCache,
                                                     WKWebsiteDataTypeOfflineWebApplicationCache,
                                                     WKWebsiteDataTypeMemoryCache,
                                                     WKWebsiteDataTypeLocalStorage,
                                                     WKWebsiteDataTypeCookies,
                                                     WKWebsiteDataTypeSessionStorage,
                                                     WKWebsiteDataTypeIndexedDBDatabases,
                                                     WKWebsiteDataTypeWebSQLDatabases
                                                     ]];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        // 结束回调
    }];
}

@end
