//
//  UITextField+XMTool.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/10.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "UITextField+XMTool.h"
#import <objc/message.h>

@implementation UITextField (XMTool)

/// 方便的初始化方法。
+ (UITextField *)getMyTextField {
    UITextField *inputTF = [[UITextField alloc] init];
    inputTF.placeholderColor = [UITextField colorFromHexString:@"#a4a9b2"];
    inputTF.backgroundColor = [UITextField colorFromHexString:@"#e6eaf2"];
    inputTF.layer.masksToBounds = YES;
    inputTF.layer.cornerRadius = 5;
    inputTF.layer.borderColor = [UITextField colorFromHexString:@"#dadde3"].CGColor;
    inputTF.layer.borderWidth = 0.8;
    /// 左边空隙
    inputTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    inputTF.leftViewMode = UITextFieldViewModeAlways;
    return  inputTF;
}

+ (void)load {
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method wg_setPlaceholderMethod = class_getInstanceMethod(self, @selector(wg_setPlaceholder:));
    // 交互方法
    method_exchangeImplementations(setPlaceholderMethod, wg_setPlaceholderMethod);
}

- (void)setDrawPlaceholderInRect:(CGRect )rect {
    UIColor *placeholderColor = [UIColor redColor];//设置颜色
    [placeholderColor setFill];
    CGRect placeholderRect = CGRectMake(rect.origin.x+10, (rect.size.height- self.font.pointSize)/2, rect.size.width, self.font.pointSize);//设置距离
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = self.textAlignment;
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:style,NSParagraphStyleAttributeName, self.font, NSFontAttributeName, placeholderColor, NSForegroundColorAttributeName, nil];
    [self.placeholder drawInRect:placeholderRect withAttributes:attr];
}

// 设置占位文字颜色
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    // 1.保存占位文字颜色到系统的类,关联
    // object:保存到哪个对象中
    // key:属性名
    // value:属性值
    // policy:策略
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (id)placeholderInRect {
    return (objc_getAssociatedObject(self, @"placeholderInRect"));
}
- (UIColor *)placeholderColor {
    return objc_getAssociatedObject(self, @"placeholderColor");
}

- (void)wg_setPlaceholder:(NSString *)placeholder {
    // 设置占位文字
    [self wg_setPlaceholder:placeholder];
    // 设置占位文字颜色
    self.placeholderColor = self.placeholderColor;
}

#pragma mark - 方便的获取16进制的颜色，不引起其他类目，避免耦合性太高。

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    return [[self class] colorWithR:((rgbValue & 0xFF0000) >> 16) G:((rgbValue & 0xFF00) >> 8) B:(rgbValue & 0xFF) A:1.0];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    
    return [[self class] colorWithR:((rgbValue & 0xFF0000) >> 16) G:((rgbValue & 0xFF00) >> 8) B:(rgbValue & 0xFF) A:alpha];
}

#pragma mark - RGBA Helper method
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

@end
