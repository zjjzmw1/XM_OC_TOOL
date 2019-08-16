
/// -------------------------- 需要引用第三方库： pod 'YYText', '~> 1.0.7' --------------------------
#import "YYLabel.h"
#import "YYText.h"

/// 下面的方法用到的block - 点击图片的回调，返回点击后展示的图片。
typedef void(^kCurrentShowImg)(UIImage * __nullable currentShowImg);

NS_ASSUME_NONNULL_BEGIN

/// -------------------------- 图文混排、点击 -- 方法封装 --------------------------
@interface YYLabel_XM : YYLabel

// ==========================---------两步实现复制的富文本BEGIN------------==========================
/// 第一步： - 初始化YYLabel_XM
+ (YYLabel_XM *)getLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment)alignment;

/// 第二步： - 添加 ”子字符串“
- (void)addAttriStr:(NSString *)str font:(UIFont *)font textColor:(UIColor *)textColor;

/// 第二步： - 添加【可点击】的 ”子字符串“
- (void)addAttriStrCanClick:(NSString *)str
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
         highLightTextColor:(UIColor *)highLightTextColor
           highLightBgColor:(UIColor *)highLightBgColor
                  tapAction:(YYTextAction)tapAction;

/// 第二步： - 添加图片 - imgSize传CGSizeZero的时候用默认为：CGSizeMake(20, 20) 图片大小会影响行间距,太大也可能会导致无法换行
- (void)addAttriImage:(UIImage *)img imgSize:(CGSize)imgSize;

/// 第二步： - 添加图片和选中图片 - imgSize是图片所占的位置大小，图片显示的大小取决于图片本身的大小。nearbyFont 和相邻文字的大小一样（太大太小都不行），否则会出现图片和文字centerY不居中的bug
- (void)addAttriImageCanClick:(UIImage *)img
                 highLightImg:(UIImage *)highLightImg
                      imgSize:(CGSize)imgSize
                       imgTag:(int)imgTag
                   nearbyFont:(UIFont *)font
               currentShowImg:(kCurrentShowImg)currentShowImg;

// ==========================---------两步实现复制的富文本END------------==========================

/// ！！(一般用不到，除非想自定义一些特殊的样式) 当前label的attributedText属性值 【或者】 想刷新富文本的时候，需要把 ‘myAttriStr’这个属性清空或者重新初始化，然后重新执行上面的第二步就ok了。
@property (nonatomic, strong) NSMutableAttributedString     *myAttriStr;

@end

NS_ASSUME_NONNULL_END
