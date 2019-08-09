//
//  NSString+XMValid.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/10.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 验证相关
@interface NSString (XMValid)

/// 判断一个字符串是否为空字符串  null , <null> 等。。
+ (BOOL)isEmptyString:(NSString *)string;
/// 判断NSString是否包含另一个字符串
- (BOOL)stringContainsSubString:(NSString *)subString;

/// 是否全是中文，，包含不算。
- (BOOL)isAllChinese;
/// 是否是合法的邮箱
+ (BOOL) validateEmail:(NSString *)email;
//判断是否是有效的有效qq
- (BOOL) validateqq;
/// 合法的中国电话号码
+ (BOOL)validateMobile:(NSString *)mobile;
/// 判断字符串是否含表情
+ (BOOL)stringContainsEmoji:(NSString *)string;
+ (BOOL)isNineKeyBoard:(NSString *)string;
/// 判断是否含有非法字符 yes 有  no没有
+ (BOOL)hasInvalidCharacter:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
