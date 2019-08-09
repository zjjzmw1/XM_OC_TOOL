//
//  XMRouterTool.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/10.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMRouterTool.h"

@implementation XMRouterTool

/// 通用的-跳转某个页面的push
+ (void)pushVC:(UIViewController *)vc {
    /// 0.5秒内不能重复push，避免多次跳转
    if ([XMRouterTool repeatCallAction:@"pushVC"]) {
        return;
    }
    if (![vc isEqual:[XMTool getCurrentVC]]) {
        vc.hidesBottomBarWhenPushed = YES;
        [[XMRouterTool getCurrentVC].navigationController pushViewController:vc animated:YES];
    }
}

/// 通用的-返回上一页
+ (void)popToRootVC:(BOOL)isToRoot {
    if (isToRoot) {
        [[XMRouterTool getCurrentVC].navigationController popToRootViewControllerAnimated:YES];
    } else {
        [[XMRouterTool getCurrentVC].navigationController popViewControllerAnimated:YES];
    }
}

/// 跳转到某一个网页 urlStr ：url地址，例如：http://www.baidu.com
+ (void)pushToWebVCUrlStr:(NSString *)urlStr titleStr:(NSString *)titleStr {
    /// 0.5秒内不能重复push，避免多次跳转
    if ([XMRouterTool repeatCallAction:@"pushToWebVCUrlStr"]) {
        return;
    }
    XMWebVC *vc = [[XMWebVC alloc] init];
    vc.urlStr = urlStr;
    vc.titleStr = titleStr;
    [[XMTool getCurrentVC].navigationController pushViewController:vc animated:YES];
}

#pragma mark - 获取当前屏幕显示的viewcontroller
+ (nullable UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [XMRouterTool getCurrentVCFrom:rootViewController];
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
        currentVC = [XMRouterTool getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        // 根视图为UINavigationController
        currentVC = [XMRouterTool getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
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
        NSLog(@"XM_Router: 频繁调用%@被拦截了",funcName);
        return YES; // 0.5秒内不能重复调用这个方法
    }
    now = [NSDate date];
    funcStr = funcName;
    return NO;
}

@end
