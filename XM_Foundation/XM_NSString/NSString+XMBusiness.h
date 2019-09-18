//
//  NSString+XMBusiness.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/25.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 偏 ”业务性“ 的字符串相关的方法
@interface NSString (XMBusiness)

/**
 获取新拼接的字符串 例如："a·b·c"
 
 @param oriStr 原始的字符串
 @param oriS 原始的分隔符
 @param newS 新的分隔符
 @return 新的字符串
 */
+ (NSString *)getNewStrWithOriStr:(NSString *)oriStr oriSeparator:(NSString *)oriS newSeparator:(NSString *)newS;

/**
 获取新拼接的字符串 例如："a·b·c"  根据数组
 
 @param arr 字符串数组
 @param newSepa 新拼接字符串的拼接符
 @return 拼接好的字符串
 */
+ (NSString *)getNewStrWithArr:(NSArray *)arr newSeparator:(NSString *)newSepa;

/// 获取多少 人次 的字符串
+ (NSString *)getPeopleCountStr:(NSString *)peopleCount;

@end

NS_ASSUME_NONNULL_END
