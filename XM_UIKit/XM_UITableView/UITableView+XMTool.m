//
//  UITableView+XMTool.m
//  艺库
//
//  Created by zhangmingwei on 2019/8/15.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "UITableView+XMTool.h"

@implementation UITableView (XMTool)

/**
 初始化表格方便的方法 -- 方便统一修改表格的属性
 
 @param frame 大小、位置
 @return 表格
 */
+ (UITableView *)getTableView:(CGRect)frame {
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.separatorInset = UIEdgeInsetsZero;
    tableView.separatorColor = [UIColor getSeparatorColor_XM];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.tableFooterView = [UIView new];
    tableView.tableHeaderView = [UIView new];
    // iOS11后，不加这三句，会出现，reloadData的时候页面闪动，滚动到其他地方的bug。
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    if (@available(iOS 11.0,*)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        //        tableView.nextResponder.automaticallyAdjustsScrollViewInsets = NO;
    }
    return tableView;
}


@end
