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
