//
//  NSNumber+XMSafe.m
//  艺库
//
//  Created by zhangmingwei on 2019/9/19.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "NSNumber+XMSafe.h"

@implementation NSNumber (XMSafe)

/// 修复崩溃： -[__NSCFNumber isEqualToString:]: unrecognized selector sent to instance 0x7c2680b0
/// 判断是否相等
- (BOOL)isEqualToString:(NSString *)str {
    NSString *newStr = [NSString stringWithFormat:@"%@",self];
    if ([newStr isEqualToString:str]) {
        return YES;
    }
    return NO;
}

@end
