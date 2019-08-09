//
//  UIColor+XMTool.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "UIColor+XMTool.h"

@implementation UIColor (XMTool)

/// 16进制获取颜色。例如：”efefef“ 或者  ”#efefef“ 或者 “0xefefef”
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    return [UIColor colorFromHexString:hexString alpha:1.0];
}
/// 16进制获取颜色。例如：”efefef“ 或者  ”#efefef“ 或者 “0xefefef”
+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithR:((rgbValue & 0xFF0000) >> 16) G:((rgbValue & 0xFF00) >> 8) B:(rgbValue & 0xFF) A:alpha];
}

/// 不建议用，所有设成私有方法：red, green, blue : 0 -- 255的数。
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

#pragma mark --------------------- 黑白色 ---------------------

/// 纯黑色 - 一般不用
+ (UIColor *)getBlackColor_0 {
    return [UIColor colorFromHexString:@"000000"];
}
/// 纯白色 - 一般不用 ffffff
+ (UIColor *)getWhiteColor_0 {
    return [UIColor colorFromHexString:@"ffffff"];
}
/// 第1黑的 黑色 - 333d40 - 常用于：标题颜色
+ (UIColor *)getBlackColor_1 {
    return [UIColor colorFromHexString:@"333d40"];
}
/// 第2黑的 黑色 - 70788c - 常用于：详情文字，比标题颜色浅一个级别
+ (UIColor *)getBlackColor_2 {
    return [UIColor colorFromHexString:@"70788c"];
}
/// 第3黑的 黑色 - a4a9b2 - 常用于：详情文字，比标题颜色浅两个级别
+ (UIColor *)getBlackColor_3 {
    return [UIColor colorFromHexString:@"a4a9b2"];
}
/// 分割线的 黑色 EAEAEA - 常用于： 表格的cell的分割线
+ (UIColor *)getSeparatorColor_XM {
    return [UIColor colorFromHexString:@"EAEAEA"];
}
/// 输入框默认文字的 黑色 cccaca - 常用于 输入框默认文字
+ (UIColor *)getPlaceHoderColor_XM {
    return [UIColor colorFromHexString:@"cccaca"];
}
/// 图片的灰色背景 cccaca
+ (UIColor *)getDefautImageColor_XM {
    return [UIColor colorFromHexString:@"#cccaca"];
}
/// 第1白的 白色 - F0F2F6 - 常用于：浅白色的背景
+ (UIColor *)getWhiteColor_1 {
    return [UIColor colorFromHexString:@"F0F2F6"];
}

#pragma mark --------------------- 彩色 ---------------------
/// 获取统一的 蓝色 的背景颜色 #68B4EC - 其他 蓝色 单独写。
+ (UIColor *)getBlueColor_XM {
    return [UIColor colorFromHexString:@"#68B4EC"];
}
/// 获取统一的黄色的背景颜色 #F6C358 - 其他 黄色 单独写。
+ (UIColor *)getYellowColor_XM {
    return [UIColor colorFromHexString:@"#F6C358"];
}
/// 获取统一的 红色 的背景颜色 #e8320d - 其他 红色 单独写。
+ (UIColor *)getRedColor_XM {
    return [UIColor colorFromHexString:@"#e8320d"];
}
/// 获取统一的 紫色 的背景颜色 #7D5D9E - 其他 紫色 单独写。
+ (UIColor *)getPurpleColor_XM {
    return [UIColor colorFromHexString:@"#7D5D9E"];
}
/// 获取统一的 绿色 的背景颜色 #35C277 -  其实更好看的绿色是：61C355 ，可惜没用。
+ (UIColor *)getGreenColor_XM {
    return [UIColor colorFromHexString:@"#35C277"];
}

@end
