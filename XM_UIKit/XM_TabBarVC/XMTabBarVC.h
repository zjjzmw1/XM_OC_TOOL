//
//  XMTabBarVC.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 用法： 就一句话，非常简单，需要的vc，在 XMTabBarVC 里面更改就ok了。
 [self.window setRootViewController:[XMTabBarVC defaultManager]];
 
 */

/// 自定义的tabbar - 方便的小红点、角标、切换等功能
@interface XMTabBarVC : UITabBarController

/// 单利
+ (instancetype)defaultManager;

/// 设置tabBar显示指定控制器
-(void)showControllerIndex:(NSInteger)index;

/**
 *  数字角标
 *  @param badge   所要显示数字
 *  @param index 位置
 */
-(void)showBadgeMark:(NSInteger)badge index:(NSInteger)index;

/// 展示某个vc的小红点
-(void)showPointMarkIndex:(NSInteger)index;

/// 隐藏指定位置角标 -- 不管是小红点还是数字都隐藏
- (void)hideMarkIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
