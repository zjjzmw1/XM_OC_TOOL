//
//  NSString+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/10.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 中文还未输入完成的时候，返回的字符串
#define kChineseNotInputOK_XM      @"zh-Hans_not_input_ok_XM"

/// 字符串相关工具类
@interface NSString (XMTool)

/// 格式化空字符串
+ (NSString *)nullToStringXM:(NSString *)string;
/// 项目中通用的md5获取方法，ok，能用
- (NSString*)md5String;
/// 根据字符串和字体大小获取frame
+ (CGRect)getSizeWithStrWidth:(NSString *)str font:(UIFont *)font width:(CGFloat)width;

/// 去除两端空格
+(NSString *)removeTrimmingBlank:(NSString *)string;
/// 去除所有空格
+(NSString *)removeAllBlank:(NSString *)string;
/// 去除两端空格和换行
+ (NSString *)quKongGeAndEnder:(NSString *)sender;

/// textFild 限制字数的方法 返回 kChineseNotInputOK_XM 就不赋值
+ (NSString *)textFieldLimtWithMaxLength:(int)maxTextLength textField:(UITextField *)textField;
/// textView 限制字数的方法 返回 kChineseNotInputOK_XM 就不赋值
+ (NSString *)textViewLimtWithMaxLength:(int)maxTextLength textView:(UITextView *)textView;

/// 获取当前时间的时间戳 的 字符串
+ (NSString *)getCurrentTimeStampStr;
/// 获取当前时间的字符串 @"yyyy-MM-dd hh:mm:ss"
+ (NSString *)getCurrentTimeStr;

/// - 截取两个特殊字符串中间的字符串。
- (NSString *)rangeWithStartString:(NSString *)startString withEndString:(NSString *)endString;
/// 去掉float类型数据后面的 无效的 0 ==========必须是有两个小数的时候才能用。=======.2f=======  完整性有待提高
+ (NSString *)clipZero:(NSString *)string;
/// 给手机号或者邮箱加*
+ (NSString *)getStarString:(NSString *)oldString;
///根据域名获取ip地址 - 可以用于控制APP的开关某一个入口，比接口方式速度快的多
+ (NSString*)getIPWithHostName:(const NSString*)hostName;
/// 获取电话号码
+ (NSString *)getPhoneNumber:(NSString *)phoneNumber;
/// 返回需要的视频图片
+ (NSString *)getVideoUrlString:(NSString *)videoUrlStr;
/// 根据 @"yyyy-MM-dd HH:mm:ss"格式的字符串返回 ： 刚刚，几分钟前，几天前的字符串
+ (NSString *)compareCurrentTime:(NSString *)str;
/// 快速检索用的
+ (NSString *)al_firstCharOfName:(NSString *)aChinenseName;
/// 把 JSON 字符串转为 NSDictionary 或者 NSArray
- (id)jsonvalue;

/// 根据String 转 date  "2012-5-4"  --> Date
+ (NSDate *)getDateFromStrYMD:(NSString *)timeStr;

/// 获取两端不同颜色的字符串
+ (NSAttributedString *)getAttributeStr:(NSString *)str1 color1:(UIColor *)color1 font1:(UIFont *)font1 str2:(NSString *)str2 color2:(UIColor *)color2 font2:(UIFont *)font2;

/// 字符串添加图片    ---  "图标 + 带颜色的文字"
+ (NSMutableAttributedString *)getImgAttributeWithImg:(UIImage *)img str:(NSString *)str color:(UIColor *)color font:(UIFont *)font;
/// 字符串添加图片 带删除线的    ---  "图标 + 带颜色的文字 带删除线"
+ (NSMutableAttributedString *)getImgAttributeWithImgStrikeLine:(UIImage *)img str:(NSString *)str color:(UIColor *)color font:(UIFont *)font;

/// html转码 - 后台返回富文本html，iOS转换为webView能加载的html字符串 （例如： &lt;转成 <，注意本来就是<p>的标签的话，调用本方法会失去样式效果，变为text文本格式了）
+ (NSString *)getWebViewHtmlStr:(NSString *)htmlStr;


/**
 *  判断字符串是否含表情
 *
 *  @param string 原有字符串
 *
 *  @return 返回是否有标题
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/// 去除所有换行和前后空格
+(NSString *)removeHeaderFooterNewlineBlank: (NSString *)string;

/**
 *  @brief 判断NSString是否包含另一个字符串
 *
 *  @param subString 子字符串
 *
 *  @return YES:包含，NO:不包含.
 */
- (BOOL)stringContainsSubString:(NSString *)subString;

/**
 *  @brief 字符串匹配正则表达式
 *
 *  @param regString 正则表达式
 *
 *  @return YES:匹配， NO:不匹配.
 */
- (BOOL)matchStringWithRegextes:(NSString*)regString;

/**
 *  @brief  将16进制字符串转换为NSData.
 *
 *  @return 16进制 data
 */
- (NSData*)hexData;

- (NSString*)digitString:(NSInteger)digit;

/**
 *  获取当前时间的时间戳。
 *
 *  @return 时间戳
 */
+(NSString *)getCurrentTimeString;

/**
 *  判断邮箱是否可用
 *
 */
- (BOOL)isValidEmail;
#pragma mark - trim string
- (NSString *)trim;

- (BOOL)isChinese;

/**
 获取字符串的size
 
 @param font 字体
 return
 */
- (CGSize)getSizeWithFont:(UIFont *)font;

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthForFont:(UIFont *)font;

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

/// 获取当前月份  例如： JAN
+ (NSString *)getCurrentMonthStr;
/// 获取当前月的第几天  例如： 23
+ (NSString *)getCurrentDayStr;

@end

NS_ASSUME_NONNULL_END
