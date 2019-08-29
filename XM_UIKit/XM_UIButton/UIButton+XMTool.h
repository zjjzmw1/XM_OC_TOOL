//
//  UIButton+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (XMTool)

/// 获取带 image/title 的按钮 (左右排列) 排序方式
typedef enum {
    imageLeft_wholeCenter   =   0,      // 图片居左，整体居中
    imageLeft_wholeLeft     =   1,      // 图片居左，整体居左
    imageleft_wholeRight    =   2,      // 图片居左，整体居右
    imageRight_wholeCenter  =   3,      // 图片居右，整体居中
    imageRight_wholeLeft    =   4,      // 图片居右，整体居左
    imageRight_wholeRight   =   5,      // 图片居右，整体居右
    
}ButtonImageTitleType;

/**
 自定义响应边界 UIEdgeInsetsMake(-3, -4, -5, -6). 表示扩大
 例如： self.btn.hitEdgeInsets = UIEdgeInsetsMake(-3, -4, -5, -6);
 */
@property(nonatomic, assign) UIEdgeInsets hitEdgeInsets;

/**
 自定义响应边界 自定义的边界的范围 范围扩大3.0
 例如：self.btn.hitScale = 3.0;
 */
@property(nonatomic, assign) CGFloat hitScale;

/*
 自定义响应边界 自定义的宽度的范围 范围扩大3.0
 例如：self.btn.hitWidthScale = 3.0;
 */
@property(nonatomic, assign) CGFloat hitWidthScale;

/*
 自定义响应边界 自定义的高度的范围 范围扩大3.0
 例如：self.btn.hitHeightScale = 3.0;
 */
@property(nonatomic, assign) CGFloat hitHeightScale;

/**
 *  获取常用的 UIButton
 *
 *  @param title      按钮文字
 *  @param titleColor 文字颜色
 *  @param font       字体
 *
 *  @return UIButton
 */
+ (UIButton *)getButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;

/**
 *  获取带 image/title 的按钮 (左右排列)
 *
 *  @param image      image
 *  @param title      title
 *  @param titleColor 字体颜色
 *  @param aFont       font
 *  @param spacing    image和title的间隔
 *  @param type       排列方式
 *
 *  @return UIButton
 */
+ (UIButton *)getButtonImageTitleWithImage:(nullable UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor spacing:(float)spacing alignmentType:(ButtonImageTitleType)type aFont:(UIFont *)aFont;

@end

NS_ASSUME_NONNULL_END
