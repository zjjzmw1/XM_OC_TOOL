//
//  UIColor+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (XMTool)

/// 16进制获取颜色。例如：”efefef“ 或者  ”#efefef“ 或者 “0xefefef”
+ (UIColor *)colorFromHexString:(NSString *)hexString;
/// 16进制获取颜色。例如：”efefef“ 或者  ”#efefef“ 或者 “0xefefef”
+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/* !!!!!!!!!!!!超出这些常用的颜色值的话，再用上面的方法自定义颜色!!!!!!!!!!!!!!*/

#pragma mark --------------------- 黑白色 ---------------------
/// 纯黑色 - 一般不用 000000
+ (UIColor *)getBlackColor_0;
/// 纯白色 - 一般不用 ffffff
+ (UIColor *)getWhiteColor_0;
/// 第1黑的 黑色 - 333d40 - 常用于：标题颜色
+ (UIColor *)getBlackColor_1;
/// 第2黑的 黑色 - 70788c - 常用于：详情文字，比标题颜色浅一个级别
+ (UIColor *)getBlackColor_2;
/// 第3黑的 黑色 - a4a9b2 - 常用于：详情文字，比标题颜色浅两个级别
+ (UIColor *)getBlackColor_3;
/// 分割线的 黑色 EAEAEA - 常用于： 表格的cell的分割线
+ (UIColor *)getSeparatorColor_XM;
/// 输入框默认文字的 黑色 cccaca - 常用于 输入框默认文字
+ (UIColor *)getPlaceHoderColor_XM;
/// 图片的灰色背景 cccaca
+ (UIColor *)getDefautImageColor_XM;
/// 第1白的 白色 - F0F2F6 - 常用于：浅白色的背景
+ (UIColor *)getWhiteColor_1;

#pragma mark --------------------- 彩色 ---------------------
/// 获取统一的 蓝色 的背景颜色 #68B4EC - 其他 蓝色 单独写。
+ (UIColor *)getBlueColor_XM;
/// 获取统一的黄色的背景颜色 #F6C358 - 其他 黄色 单独写。
+ (UIColor *)getYellowColor_XM;
/// 获取统一的 红色 的背景颜色 #e8320d - 其他 红色 单独写。
+ (UIColor *)getRedColor_XM;
/// 获取统一的 紫色 的背景颜色 #7D5D9E - 其他 紫色 单独写。
+ (UIColor *)getPurpleColor_XM;
/// 获取统一的 绿色 的背景颜色 #61C355 - 其他 绿色 单独写。
+ (UIColor *)getGreenColor_XM;

@end

NS_ASSUME_NONNULL_END
