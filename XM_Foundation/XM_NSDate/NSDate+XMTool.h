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

/// 返回 @"yyyy-MM-dd HH:mm:ss" 类型的字符串
- (NSString *)dateString;
/// 返回 format类型的字符串 - 传入格式例如：@"yyyy-MM-dd HH:mm:ss"
- (NSString *)dateStrWithFormat:(NSString *)format;
/// 距离当前时间的间隔：1分钟内、几分钟前、几天前、等 -- 类似朋友圈、微博 - 的时间展示
- (NSString *)fromNowTimeIntervalDescription;

@end

NS_ASSUME_NONNULL_END
