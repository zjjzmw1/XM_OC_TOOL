//
//  NSString+XMValid.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/10.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "NSString+XMValid.h"

@implementation NSString (XMValid)

/// 是否是空字符串
+ (BOOL)isEmptyString:(NSString *)string {
    NSString *lastStr = [NSString stringWithFormat:@"%@",string]; // 防止string为其他类型，比如NSNumber类型
    if (lastStr == nil) {
        return YES;
    }
    if ([lastStr isKindOfClass:[[NSNull null] class]]) {
        return YES;
    }
    if ([lastStr isEqualToString:@""]) {
        return YES;
    }
    if ([lastStr isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([lastStr isEqualToString:@"null"]) {
        return YES;
    }
    if ([lastStr isEqualToString:@"(null)"]) {
        return YES;
    }
    return NO;
}

/// 是否包含某个字符串
- (BOOL)stringContainsSubString:(NSString *)subString {
    NSRange aRange = [self rangeOfString:subString];
    if (aRange.location == NSNotFound) {
        return NO;
    }
    return YES;
}

/// 是否全是中文，，包含不算。
- (BOOL)isAllChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

/// 合法的邮箱
+ (BOOL) validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)validateqq {
    NSString *qqRegex = @"[1-9][0-9]{5,10}";
    NSPredicate *qqTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqRegex];
    return [qqTest evaluateWithObject:self];
}

/// 合法的中国手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile {
    /// 由于手机号的规则变化太快，很多正则短时间就过时了，产品觉得 11位就ok
    if (mobile.length == 11) {
        return YES;
    }
    return NO;
}

#pragma mark - 判断字符串是否包含表情
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (BOOL)isNineKeyBoard:(NSString *)string {
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++) {
        if (!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

/// 判断是否含有非法字符 yes 有  no没有
+ (BOOL)hasInvalidCharacter:(NSString *)content {
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}

@end
