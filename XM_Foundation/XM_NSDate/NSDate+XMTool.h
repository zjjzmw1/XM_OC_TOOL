//
//  NSDate+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (XMTool)

/// 获取时间的字符串 "yyyy-MM-dd HH:mm:ss"
- (NSString *)getDateStr_XM;
/// 根据 "yyyy-MM-dd HH:mm:ss" 格式的字符串，返回NSdate格式的时间
+ (NSDate *)getDate_XM:(NSString *)dateStr_XM;
/// 上次存储的时间，距离当前时间的间隔 秒: 例如：距离上次存储时间，距离现在是  20秒
+ (NSTimeInterval)fromNowTimeInterval_XM:(NSString *)lastDateStr;

/// 返回 @"yyyy-MM-dd HH:mm:ss" 类型的字符串
- (NSString *)dateString;
/// 返回 format类型的字符串 - 传入格式例如：@"yyyy-MM-dd HH:mm:ss"
- (NSString *)dateStrWithFormat:(NSString *)format;
/// 距离当前时间的间隔：1分钟内、几分钟前、几天前、等 -- 类似朋友圈、微博 - 的时间展示
- (NSString *)fromNowTimeIntervalDescription;

@end

NS_ASSUME_NONNULL_END
