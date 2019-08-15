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
 初始化表格方便的方法 -- 方便统一修改表格的属性
 
 @param frame 大小、位置
 @return 表格
 */
+ (UITableView *)getTableView:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
