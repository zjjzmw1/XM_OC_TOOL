//
//  UIScrollView+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/8/22.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (XMTool)

/// 滚动到顶部
- (void)scrollToTopAnimated_XM:(BOOL)animated;
/// 滚动到底部
- (void)scrollToBottomAnimated_XM:(BOOL)animated;
/// 滚动到左边
- (void)scrollToLeftAnimated_XM:(BOOL)animated;
/// 滚动到右边
- (void)scrollToRightAnimated_XM:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
