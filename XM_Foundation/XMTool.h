//
//  XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMTool : NSObject

// --------------------------HUD常用方法封装，方便随时更换HUD第三方 BEGIN-------------------------
/// 一直loading动画的HUD -- 背景可以点击
+ (void)showHUD;
/// 一直loading动画的HUD -- 背景不可点击
+ (void)showHUDInWindow:(NSString *)loadingStr;
/// 弹出hud提示。 1.5s后自动消失
+ (void)showTipHUD:(NSString *)tipStr;
/// 隐藏HUD 0 就是立刻消失，  秒数
+ (void)dismissHUD:(NSTimeInterval)time;
// --------------------------HUD常用方法封装，方便随时更换HUD第三方 END-------------------------

/// 返回联网状态： 0：未联网，1：4G  2: wifi
+ (int)getCurrentNetworkInt;
/// 获取当前屏幕显示的viewcontroller
+ (nullable UIViewController *)getCurrentVC;

/// 移除掉navigationController栈中某一个viewController
+ (void)removeVC:(UIViewController *)currentVC;

/// 保证一个方法在0.5秒内不能重复调用
+ (BOOL)repeatCallAction:(NSString *)funcName;
/// 保证一个方法在 1 秒内不能重复调用 -- 倒计时的时候用
+ (BOOL)repeatCallActionInOneSecond:(NSString *)funcName;

/// 设置tabBar显示指定控制器
+ (void)showTabbarVCIndex:(NSInteger)index;

///  显示tabbar的数字角标  badge: 所要显示数字
+ (void)showBadgeMark:(NSInteger)badge index:(NSInteger)index;

/// 展示某个vc的小红点
+ (void)showPointMarkIndex:(NSInteger)index;

/// 隐藏指定位置角标 -- 不管是小红点还是数字都隐藏
+ (void)hideMarkIndex:(NSInteger)index;

#pragma mark ==========================获取空间大小相关 BEGIN===================================
/// 获取本地视频的缓存大小。---- 这里可以根据自己项目存储的位置选择修改。
+ (float )getLocalVideoCacheSize_XM;
/// 获取手机剩余空间大小单位是：bytes
+ (float)getMyPhoneFreeSize_XM;
/// 获取某个文件夹的大小 单位：bytes
+ (float)getFolderSizeAtPath_XM:(NSString *)folderPath;
/// 获取单个文件的大小 单位：bytes
+ (long long)getFileSizeAtPath_XM:(NSString*)filePath;
/// 根据 byte的大小，返回 多少GB /MB/KB/B
+ (NSString *)getFileSizeStringFromBytes_XM:(uint64_t)byteSize;
#pragma mark ==========================获取空间大小相关 END===================================

// 清除网页缓存 WKWebsiteDataStore
+ (void)clearWKWebViewCache_XM;

@end

NS_ASSUME_NONNULL_END
