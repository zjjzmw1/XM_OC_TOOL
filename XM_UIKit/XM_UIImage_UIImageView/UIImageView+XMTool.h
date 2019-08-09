//
//  UIImageView+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (XMTool)

/**
 *  获取常用的 UIImageView  默认：UIViewContentModeScaleAspectFill;     ///这个是取中间的一部分。。不压缩的。
 *
 *  @param frame 设置圆角的时候需要
 *
 *  @return UIImageView
 */
+ (UIImageView *)getImageViewFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
