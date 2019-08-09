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

@end

NS_ASSUME_NONNULL_END
