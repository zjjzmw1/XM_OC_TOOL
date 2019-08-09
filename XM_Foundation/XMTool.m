//
//  XMTool.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMTool.h"

@implementation XMTool

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
        NSLog(@"XMTool: 小于1秒就调用%@被拦截了",funcName);
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



@end
