//
//  NSArray+XMSafe.m
//  艺库
//
//  Created by zhangmingwei on 2019/8/16.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "NSArray+XMSafe.h"
#import <objc/runtime.h>
#import "NSObject+XMRuntime.h"

@implementation NSArray (XMSafe)

/// 编译项目的时候就会执行，不用担心不执行。
+ (void)load {
    // 数组越界的处理 ----------------------BEGIN-------------------------------
    SEL safeSel = @selector(xm_safeObjectAtIndex:);
    SEL unsafeSel = @selector(objectAtIndex:);
    Class class = NSClassFromString(@"__NSArrayI");
    Method safeMethod = class_getInstanceMethod(class, safeSel);
    Method unsafeMethod = class_getInstanceMethod(class, unsafeSel);
    method_exchangeImplementations(unsafeMethod, safeMethod);
    // 数组越界的处理 ----------------------END-------------------------------
    // 数组插入 nil 的处理 ----------------------BEGIN-------------------------------
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *obj = [[NSMutableArray alloc] init];
        // 对象方法 __NSArrayM 和 __NSArrayI 都有实现，都要swizz
        [obj xm_swizzleMethod:@selector(addObject:) swizzledSelector:@selector(xm_addObject:)];
        [obj xm_swizzleMethod:@selector(insertObject:atIndex:) swizzledSelector:@selector(xm_insertObject:atIndex:)];
    });
    // 数组插入 nil 的处理 ----------------------END-------------------------------
}
/// 数组越界的处理
- (id)xm_safeObjectAtIndex:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (index > (self.count - 1)) { // 数组越界
        NSAssert(NO, @"数组越界了"); // NSAssert 只有开发的时候才会造成程序崩了
        return nil;
    } else { // 没有越界
        return [self xm_safeObjectAtIndex:index];
    }
}
/// 插入nil的处理
- (void)xm_addObject:(id)obj {
    if (obj) {
        [self xm_addObject:obj];
    } else {
        // NSAssert 只有开发的时候才会造成程序崩溃，方便调试解决问题
        NSAssert(NO, @"尝试插入 nil :xm_addObject");
    }
}
/// 插入空，越界的崩溃处理
- (void)xm_insertObject:(id)obj atIndex:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (index > (self.count - 1)) { // 数组越界
        NSAssert(NO, @"数组越界了,xm_insertObject"); // NSAssert 只有开发的时候才会造成程序崩了
    } else { // 没越界
        if (obj) { // 不为空
            [self xm_insertObject:obj atIndex:index];
        } else {
            // NSAssert 只有开发的时候才会造成程序崩溃，方便调试解决问题
            NSAssert(NO, @"尝试插入 nil :xm_insertObject");
        }
    }
}

@end
