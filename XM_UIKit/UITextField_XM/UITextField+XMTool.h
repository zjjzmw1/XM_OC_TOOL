//
//  UITextField+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/10.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (XMTool)
/// 内边距 --- 左边空隙的解决方案
//UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 50)];
//self.nameTF.leftView = paddingView;
//self.nameTF.leftViewMode = UITextFieldViewModeAlways;

/// 默认文字的颜色
@property (nonatomic, strong) UIColor *placeholderColor;
/// 方便的初始化方法。  ------ 左边有 8px 的空隙
+ (UITextField *)getMyTextField;

@end

NS_ASSUME_NONNULL_END
