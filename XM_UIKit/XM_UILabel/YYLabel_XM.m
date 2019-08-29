//
//  YYLabel_XM.m
//  艺库
//
//  Created by zhangmingwei on 2019/8/15.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "YYLabel_XM.h"
#import "XMSizeMacro.h"
#import "XMToolMacro.h"

@interface YYLabel_XM()

/// 对齐方式
@property (nonatomic, assign) NSTextAlignment       myAlignment;
/// 记录当前图片的标记字典
@property (nonatomic, strong) NSMutableDictionary   *imgDict;

@end

@implementation YYLabel_XM

/// 第一步： - 初始化YYLabel_XM
+ (YYLabel_XM *)getLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment)alignment {
    //1.简单显示label
    YYLabel_XM *label = [[YYLabel_XM alloc] init];
    label.frame = frame;
    //异步渲染 当一个label显示巨量文字的时候就能明显感觉到此功能的强大
    label.displaysAsynchronously = YES;
    label.myAttriStr = [[NSMutableAttributedString alloc] initWithString:@""];
    /// 在这里设置对齐方式无效，必须在赋值后面设置才行
    label.myAlignment = alignment;
    label.imgDict = [NSMutableDictionary dictionary];
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = kScreenWidth_XM - 100;
    return label;
}

/// 第二步： - 添加 ”子字符串“
- (void)addAttriStr:(NSString *)str font:(UIFont *)font textColor:(UIColor *)textColor {
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    attri.yy_color = textColor; // 整个的颜色
    [attri yy_setFont:font range:NSMakeRange(0, str.length)]; // 某段字符串的字体两种方式都行。
    [self.myAttriStr appendAttributedString:attri];
    /// 最终赋值
    [self lastUpdateAction];
}

/// 第二步： - 添加【可点击】的 ”子字符串“
- (void)addAttriStrCanClick:(NSString *)str
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
    /// 添加到总的图文
    [self.myAttriStr appendAttributedString:attri];
    /// 最终赋值
    [self lastUpdateAction];
}

/// 第二步： - 添加图片 - imgSize传CGSizeZero的时候用默认为：CGSizeMake(20, 20)
- (void)addAttriImage:(UIImage *)img imgSize:(CGSize)imgSize {
    CGSize lastImgSize = imgSize;
    if (imgSize.width == 0 || imgSize.height == 0) {
        lastImgSize = CGSizeMake(20, 20);
    }

    NSMutableAttributedString *attachText = [NSMutableAttributedString  yy_attachmentStringWithContent:img contentMode:UIViewContentModeCenter attachmentSize:lastImgSize alignToFont:FontWithSize(15) alignment:YYTextVerticalAlignmentCenter];
    /// 添加到总的图文
    [self.myAttriStr appendAttributedString:attachText];
    /// 最终赋值
    [self lastUpdateAction];
}

/// 第二步： - 添加图片和选中图片 - imgSize是图片所占的位置大小，图片显示的大小取决于图片本身的大小。nearbyFont 和相邻文字的大小一样（太大太小都不行），否则会出现图片和文字centerY不居中的bug
- (void)addAttriImageCanClick:(UIImage *)img
                 highLightImg:(UIImage *)highLightImg
                      imgSize:(CGSize)imgSize
                       imgTag:(int)imgTag
                   nearbyFont:(UIFont *)font
               currentShowImg:(kCurrentShowImg)currentShowImg {
    CGSize lastImgSize = imgSize;
    if (imgSize.width == 0 || imgSize.height == 0) {
        lastImgSize = CGSizeMake(20, 20);
    }
    /// 添加当前图片标记
    [self.imgDict setObject:[NSString stringWithFormat:@"%d",(int)self.textLayout.attachments.count] forKey:[NSString stringWithFormat:@"%d",imgTag]];
    /// alignToFont 要和当前图片相邻的文字字体一样大，否则图片centerY不居中。
    NSMutableAttributedString *attachText = [NSMutableAttributedString  yy_attachmentStringWithContent:img contentMode:UIViewContentModeCenter attachmentSize:lastImgSize alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    __weak typeof(self) wSelf = self;
    [attachText yy_setTextHighlightRange:NSMakeRange(0, attachText.length) color:[UIColor clearColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //获取图片资源
        NSArray *attachments =  wSelf.textLayout.attachments;
        for (int i = 0; i < attachments.count; i++) {
            YYTextAttachment *attachment = attachments[i];
            /// 获取当前图片的标记
            int currentImgRow = [[wSelf.imgDict objectForKey:[NSString stringWithFormat:@"%d",imgTag]] intValue];
            if (currentImgRow == i) { // 确实是点击的图片，才更换
                if ([attachment.content isEqual:img]) {
                    attachment.content = highLightImg;
                } else {
                    attachment.content = img;
                }
                currentShowImg((UIImage *)attachment.content);
            }
        }
    }];
    /// 添加到总的图文
    [self.myAttriStr appendAttributedString:attachText];
    /// 最终赋值
    [self lastUpdateAction];
}

/// 最终调用统一的赋值方法
- (void)lastUpdateAction {
    /// 把总的图文赋值给label
    self.attributedText = self.myAttriStr;
    /// 对齐方式 -- 必须在赋值后，设置对齐方式才生效。
    self.myAttriStr.yy_alignment = self.myAlignment;
}

@end
