//
//  UIViewController+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 滑动返回的导航栏相关处理方法
@interface UIViewController (XMTool)

/// 是否隐藏默认导航栏,默认NO - (需要在页面的 viewDidLoad 中设置隐藏或显示)
- (void)xm_hiddenCurrenPageNavi:(BOOL)isHidden;

/// 禁止当前页面滑动返回 -- (需要在页面的 viewWillappear 中添加) ---- 和下面的方法成对使用
- (void)xm_forbidCurrentNaviSwipeBackAction;

/// 离开当前页面前恢复滑动返回 - (需要在 viewwillDisappear 中添加) ---- 和上面的方法成对使用
- (void)xm_restoreCurrentNaviSwipeBackAction;

@end

NS_ASSUME_NONNULL_END
