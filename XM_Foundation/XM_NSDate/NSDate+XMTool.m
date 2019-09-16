//
//  NSDate+XMTool.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "NSDate+XMTool.h"

@implementation NSDate (XMTool)

/// 获取时间的字符串 "yyyy-MM-dd HH:mm:ss"
- (NSString *)getDateStr_XM {
    NSString *format = @"yyyy-MM-dd HH:mm:ss";
    return [self dateStrWithFormat:format];
}
/// 根据 "yyyy-MM-dd HH:mm:ss" 格式的字符串，返回NSdate格式的时间
+ (NSDate *)getDate_XM:(NSString *)dateStr_XM {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *format = @"yyyy-MM-dd HH:mm:ss";
    formatter.dateFormat = format;
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    NSDate *lastDate = [formatter dateFromString:dateStr_XM];
    return lastDate;
}

/// 上次存储的时间，距离当前时间的间隔 秒: 例如：距离上次存储时间，距离现在是  20秒
+ (NSTimeInterval)fromNowTimeInterval_XM:(NSString *)lastDateStr {
    NSDate *lastDate = [NSDate getDate_XM:lastDateStr];
    return -[lastDate timeIntervalSinceNow];
}

/// 返回 @"yyyy-MM-dd HH:mm:ss" 类型的字符串
- (NSString *)dateString {
    NSString *format = @"yyyy-MM-dd HH:mm:ss";
    return [self dateStrWithFormat:format];
}
/// 返回 format类型的字符串 - 传入格式例如：@"yyyy-MM-dd HH:mm:ss"
- (NSString *)dateStrWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    NSString *dateString = [formatter stringFromDate:self];
    return dateString;
}

/// 距离当前时间的间隔：1分钟内、几分钟前、几天前、等
- (NSString *)fromNowTimeIntervalDescription {
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return NSLocalizedString(@"1分钟内", @"");
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:NSLocalizedString(@"%.0f分钟前", @""), timeInterval / 60];
    } else if (timeInterval < 86400) {
        return [NSString stringWithFormat:NSLocalizedString(@"%.0f小时前", @""), timeInterval / 3600];
    } else if (timeInterval < 2592000) {//30天内
        return [NSString stringWithFormat:NSLocalizedString(@"%.0f天前", @""), timeInterval / 86400];
    } else if (timeInterval < 31536000) {//30天至1年内
        return [self dateStrWithFormat:NSLocalizedString(@"M月d日", @"")];
    } else {
        return [NSString stringWithFormat:NSLocalizedString(@"%.f年前", @""), timeInterval / 31536000];
    }
}

@end
