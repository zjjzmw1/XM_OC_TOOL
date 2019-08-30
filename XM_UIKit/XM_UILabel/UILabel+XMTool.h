//
//  UILabel+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (XMTool)

/**
 修改label内容距 `top` `left` `bottom` `right` 边距
 */
@property (nonatomic, assign) UIEdgeInsets xm_contentInsets;

/// 便利的 获取常用的 UILabel --- 默认左对齐
+ (UILabel *)getLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor;
/**
 *  获取常用的UILabel
 *
 *  @param font      UIFont
 *  @param text      NSString
 *  @param textColor UIColor
 *
 *  @return UILabel
 */
+ (UILabel *)getLabelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor;

/// 设置多行的行间距
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

@end

NS_ASSUME_NONNULL_END
