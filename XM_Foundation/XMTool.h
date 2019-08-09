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
