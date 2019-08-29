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


@end

NS_ASSUME_NONNULL_END
