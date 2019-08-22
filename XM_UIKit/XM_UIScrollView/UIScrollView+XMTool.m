//
//  UIScrollView+XMTool.m
//  艺库
//
//  Created by zhangmingwei on 2019/8/22.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "UIScrollView+XMTool.h"

@implementation UIScrollView (XMTool)

/// 滚动到顶部
- (void)scrollToTopAnimated_XM:(BOOL)animated {
    CGPoint offset = self.contentOffset;
    offset.y = - self.contentInset.top;
    [self setContentOffset:offset animated:animated];
}
/// 滚动到底部
- (void)scrollToBottomAnimated_XM:(BOOL)animated {
    CGPoint offset = self.contentOffset;
    offset.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:offset animated:animated];
}
/// 滚动到左边
- (void)scrollToLeftAnimated_XM:(BOOL)animated {
    CGPoint offset = self.contentOffset;
    offset.x = - self.contentInset.left;
    [self setContentOffset:offset animated:animated];
}
/// 滚动到右边
- (void)scrollToRightAnimated_XM:(BOOL)animated {
    CGPoint offset = self.contentOffset;
    offset.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:offset animated:animated];
}


@end
