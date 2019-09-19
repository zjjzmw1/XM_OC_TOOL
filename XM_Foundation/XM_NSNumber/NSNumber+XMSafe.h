//
//  NSNumber+XMSafe.h
//  艺库
//
//  Created by zhangmingwei on 2019/9/19.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 修复崩溃的bug
@interface NSNumber (XMSafe)

/// 修复崩溃： -[__NSCFNumber isEqualToString:]: unrecognized selector sent to instance 0x7c2680b0
/// 判断字符串是否相等
- (BOOL)isEqualToString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
