//
//  XMRouterTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/10.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// - 简单的路由 -
@interface XMRouterTool : NSObject

/// 通用的-跳转某个页面的push
+ (void)pushVC:(UIViewController *)vc;

/// 通用的-返回上一页
+ (void)popToRootVC:(BOOL)isToRoot;

/// 跳转到某一个网页 urlStr ：url地址，例如：http://www.baidu.com
+ (void)pushToWebVCUrlStr:(NSString *)urlStr titleStr:(NSString *)titleStr;

@end

NS_ASSUME_NONNULL_END
