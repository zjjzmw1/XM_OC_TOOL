//
//  UITableView+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/8/15.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (XMTool)

/**
 便捷的初始化 UITableView的类方法
 */
+ (instancetype)instanceWithType:(UITableViewStyle)style;

/**
 section 不值顶的方法
 */
- (void)setSectionHeaderNotTopWithHeight:(CGFloat)sectionHeight;

@end

NS_ASSUME_NONNULL_END
