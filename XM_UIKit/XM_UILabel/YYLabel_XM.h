
/// -------------------------- 需要引用第三方库： pod 'YYText', '~> 1.0.7' --------------------------
#import "YYLabel.h"
#import "YYText.h"

NS_ASSUME_NONNULL_BEGIN

/// -------------------------- 图文混排、点击 -- 方法封装 --------------------------
@interface YYLabel_XM : YYLabel

// ==========================---------两步实现复制的富文本BEGIN------------==========================
/// 第一步： - 初始化YYLabel_XM
+ (YYLabel_XM *)getLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment)alignment;

/// 第二步： - 添加 ”子字符串“
- (void)addAttri:(NSString *)str font:(UIFont *)font textColor:(UIColor *)textColor;

/// 第二步： - 添加【可点击】的 ”子字符串“
- (void)addAttriCanClick:(NSString *)str
                    font:(UIFont *)font
               textColor:(UIColor *)textColor
      highLightTextColor:(UIColor *)highLightTextColor
        highLightBgColor:(UIColor *)highLightBgColor
               tapAction:(YYTextAction)tapAction;

// ==========================---------两步实现复制的富文本END------------==========================

/// ！！(一般用不到，除非想自定义一些特殊的样式) 当前label的attributedText属性值 【或者】 想刷新富文本的时候，需要把 ‘myAttriStr’这个属性清空或者重新初始化，然后执行上面的第二步就ok了。
@property (nonatomic, strong) NSMutableAttributedString     *myAttriStr;

@end

NS_ASSUME_NONNULL_END
