//
//  NSArray+XMSafe.m
//  艺库
//
//  Created by zhangmingwei on 2019/8/16.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "NSArray+XMSafe.h"
#import <objc/runtime.h>

@implementation NSArray (XMSafe)

/// 编译项目的时候就会执行，不用担心不执行。
+ (void)load {
    // 选择器
    SEL safeSel = @selector(xm_safeObjectAtIndex:);
    SEL unsafeSel = @selector(objectAtIndex:);
    Class class = NSClassFromString(@"__NSArrayI");
    // 方法
    Method safeMethod = class_getInstanceMethod(class, safeSel);
    Method unsafeMethod = class_getInstanceMethod(class, unsafeSel);
    // 交换方法
    method_exchangeImplementations(unsafeMethod, safeMethod);
}

- (id)xm_safeObjectAtIndex:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (index > (self.count - 1)) { // 数组越界
        NSAssert(NO, @"数组越界了"); // NSAssert 只有开发的时候才会造成程序崩了
        return nil;
    } else { // 没有越界
        return [self xm_safeObjectAtIndex:index];
    }
}

@end
