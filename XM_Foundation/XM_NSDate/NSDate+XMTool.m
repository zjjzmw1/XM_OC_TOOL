//
//  NSDate+XMTool.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "NSDate+XMTool.h"

@implementation NSDate (XMTool)

/// 返回 @"yyyy-MM-dd HH:mm:ss" 类型的字符串
- (NSString *)dateString {
    NSString *format = @"yyyy-MM-dd HH:mm:ss";
    return [self dateStrWithFormat:format];
}
/// 返回 format类型的字符串 - 传入格式例如：@"yyyy-MM-dd HH:mm:ss"
- (NSString *)dateStrWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSString *dateString = [formatter stringFromDate:self];
    return dateString;
}

@end
