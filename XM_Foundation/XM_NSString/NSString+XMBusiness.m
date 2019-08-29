//
//  NSString+XMBusiness.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/25.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "NSString+XMBusiness.h"
#import "NSString+XMValid.h"

@implementation NSString (XMBusiness)

/**
 获取新拼接的字符串 例如："a·b·c"
 
 @param oriStr 原始的字符串
 @param oriS 原始的分隔符
 @param newS 新的分隔符
 @return 新的字符串
 */
+ (NSString *)getNewStrWithOriStr:(NSString *)oriStr oriSeparator:(NSString *)oriS newSeparator:(NSString *)newS {
    NSString *oldStr = [NSString stringWithFormat:@"%@",oriStr];
    NSString *lastStr = oldStr;
    if (![NSString isEmptyString:oldStr]) {
        lastStr = [oldStr stringByReplacingOccurrencesOfString:oriS withString:newS];
    } else {
        lastStr = @"";
    }
    return lastStr;
}

/**
 获取新拼接的字符串 例如："a·b·c"  根据数组

 @param arr 字符串数组
 @param newSepa 新拼接字符串的拼接符
 @return 拼接好的字符串
 */
+ (NSString *)getNewStrWithArr:(NSArray *)arr newSeparator:(NSString *)newSepa {
    NSString *lastStr = @"";
    for (int i = 0; i < arr.count; i++) {
        NSString *tempStr = [NSString stringWithFormat:@"%@",arr[i]];
        if (i == 0) {
            lastStr = tempStr;
        } else {
            lastStr = [NSString stringWithFormat:@"%@%@%@",lastStr,newSepa,tempStr];
        }
    }
    return lastStr;
}


@end
