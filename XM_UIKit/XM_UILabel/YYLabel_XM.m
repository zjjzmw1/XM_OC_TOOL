//
//  YYLabel_XM.m
//  艺库
//
//  Created by zhangmingwei on 2019/8/15.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "YYLabel_XM.h"

@implementation YYLabel_XM

/// 初始化YYLabel_XM
+ (YYLabel_XM *)getLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment)alignment {
    //1.简单显示label
    YYLabel_XM *label = [[YYLabel_XM alloc] init];
    label.userInteractionEnabled = YES;
    label.frame = frame;
    label.numberOfLines = 0; // 默认可以多行展示
    label.myAttriStr = [[NSMutableAttributedString alloc] initWithString:@""];
    label.myAttriStr.yy_alignment = alignment; // 整个label的对齐方式，直接设置label.textalignment无效。
    return label;
}

/// 添加 ”子字符串“
- (void)addAttri:(NSString *)str font:(UIFont *)font textColor:(UIColor *)textColor {
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    attri.yy_color = textColor; // 整个的颜色
    [attri yy_setFont:font range:NSMakeRange(0, str.length)]; // 某段字符串的字体两种方式都行。
    [self.myAttriStr appendAttributedString:attri];
    // 赋值给YYLabel
    self.attributedText = self.myAttriStr;
}

/// 添加【可点击】的 ”子字符串“
- (void)addAttriCanClick:(NSString *)str
                    font:(UIFont *)font
                    textColor:(UIColor *)textColor
                    highLightTextColor:(UIColor *)highLightTextColor
                    highLightBgColor:(UIColor *)highLightBgColor
                    tapAction:(YYTextAction)tapAction {
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    attri.yy_color = textColor;
    attri.yy_font = font; // 整个的字体
    [attri yy_setFont:font range:NSMakeRange(0, str.length)];//某段的字体,和上面一行目前是一样
    /// 选中状态的颜色和点击事件
    [attri yy_setTextHighlightRange:NSMakeRange(0, str.length) color:highLightTextColor backgroundColor:highLightBgColor tapAction:tapAction];
    [self.myAttriStr appendAttributedString:attri];
    // 赋值给YYLabel
    self.attributedText = self.myAttriStr;
}

@end
