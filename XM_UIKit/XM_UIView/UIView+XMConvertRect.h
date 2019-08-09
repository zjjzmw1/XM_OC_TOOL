//
//  UIView+XMConvertRect.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/12.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XMConvertRect)

/**
 获取当前视图，相对于，传入view的 x,y 值
 @param view 指定的view
 @return 相对于指定view的point值
 */
- (CGPoint)getOriginFromView:(UIView *)view;

/**
 获取当前视图，相对于，传入view的坐标位置。
 @param view 指定的view
 @return 相对于指定view的frame值
 */
- (CGRect)getFrameFromView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
