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
/// NSArray情况特殊，多个 __NSArray0、__NSSingleObjectArrayI、__NSArrayI 等，都需要交互，并且交互的方法不能用通一个，否则崩溃。
/// ！！！！！！！！！！！！即使多个交换的方法处理都一样，也不能公用一个，否则崩溃！！！！！！！！！！！！！！！！！！
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 数组越界的处理 ----------------------BEGIN-------------------------------
        // 【不可变】 空数组
        [objc_getClass("__NSArray0") xm_swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(objectIndex_NSArray0:)];
        // 【不可变】  单个元素的
        [objc_getClass("__NSSingleObjectArrayI") xm_swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(xm_safeObjectAtIndex_NSSingleObjectArrayI:)];
        // 【不可变】  多个元素
        [objc_getClass("__NSArrayI") xm_swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(xm_safeObjectAtIndex_NSArrayI:)];
        [objc_getClass("__NSArrayI") xm_swizzleMethod:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(xm_safeObjectAtIndexedSubscript_NSArrayI:)];
        // 【可变】 单个元素
        [objc_getClass("__NSSingleObjectArrayM") xm_swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(xm_safeObjectAtIndex_NSSingleObjectArrayM:)];
        // 【可变】  空元素 或者 多个元素
        [objc_getClass("__NSArrayM") xm_swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(xm_safeObjectAtIndex_NSArrayM:)];
        [objc_getClass("__NSArrayM") xm_swizzleMethod:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(xm_safeObjectAtIndexedSubscript_NSArrayM:)];
        
        // 【可变】 特有的方法
        [objc_getClass("__NSArrayM") xm_swizzleMethod:@selector(addObject:) swizzledSelector:@selector(xm_addObject_NSArrayM:)];
        [objc_getClass("__NSArrayM") xm_swizzleMethod:@selector(insertObject:atIndex:) swizzledSelector:@selector(xm_insertObject_NSArrayM:atIndex:)];
        // 数组越界的处理 ----------------------END-------------------------------
    });
}

// 【不可变】 空数组
- (id)objectIndex_NSArray0:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (self.count <= index) { // 数组越界
        NSAssert(NO, @"数组越界了objectIndex_NSArray0"); // NSAssert 只有开发的时候才会造成程序崩了
        return nil;
    } else { // 没有越界
        return [self objectIndex_NSArray0:index];
    }
}
// 【不可变】  单个元素的
- (id)xm_safeObjectAtIndex_NSSingleObjectArrayI:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (self.count <= index) { // 数组越界
        NSAssert(NO, @"数组越界了xm_safeObjectAtIndex_NSSingleObjectArrayI"); // NSAssert 只有开发的时候才会造成程序崩了
        return nil;
    } else { // 没有越界
        return [self xm_safeObjectAtIndex_NSSingleObjectArrayI:index];
    }
}
// 【不可变】  多个元素
- (id)xm_safeObjectAtIndex_NSArrayI:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (self.count <= index) { // 数组越界
        NSAssert(NO, @"数组越界了xm_safeObjectAtIndex"); // NSAssert 只有开发的时候才会造成程序崩了
        return nil;
    } else { // 没有越界
        return [self xm_safeObjectAtIndex_NSArrayI:index];
    }
}
// 【不可变】  多个元素
- (id)xm_safeObjectAtIndexedSubscript_NSArrayI:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (self.count <= index) { // 数组越界
        NSAssert(NO, @"数组越界了xm_safeObjectAtIndexedSubscript"); // NSAssert 只有开发的时候才会造成程序崩了
        return nil;
    } else { // 没有越界
        return [self xm_safeObjectAtIndexedSubscript_NSArrayI:index];
    }
}
// 【可变】 单个元素
- (id)xm_safeObjectAtIndex_NSSingleObjectArrayM:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (self.count <= index) { // 数组越界
        NSAssert(NO, @"数组越界了xm_safeObjectAtIndex_NSSingleObjectArrayM"); // NSAssert 只有开发的时候才会造成程序崩了
        return nil;
    } else { // 没有越界
        return [self xm_safeObjectAtIndex_NSSingleObjectArrayM:index];
    }
}
// 【可变】  空元素 或者 多个元素
- (id)xm_safeObjectAtIndex_NSArrayM:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (self.count <= index) { // 数组越界
        NSAssert(NO, @"数组越界了xm_safeObjectAtIndex_NSArrayM"); // NSAssert 只有开发的时候才会造成程序崩了
        return nil;
    } else { // 没有越界
        return [self xm_safeObjectAtIndex_NSArrayM:index];
    }
}
// 【可变】  多个元素
- (id)xm_safeObjectAtIndexedSubscript_NSArrayM:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (self.count <= index) { // 数组越界
        NSAssert(NO, @"数组越界了xm_safeObjectAtIndexedSubscript_NSArrayM"); // NSAssert 只有开发的时候才会造成程序崩了
        return nil;
    } else { // 没有越界
        return [self xm_safeObjectAtIndexedSubscript_NSArrayM:index];
    }
}

/// 插入nil的处理
- (void)xm_addObject_NSArrayM:(id)obj {
    if (obj) {
        [self xm_addObject_NSArrayM:obj];
    } else {
        // NSAssert 只有开发的时候才会造成程序崩溃，方便调试解决问题
        NSAssert(NO, @"尝试插入 nil :xm_addObject_NSArrayM");
    }
}
/// 插入空，越界的崩溃处理
- (void)xm_insertObject_NSArrayM:(id)obj atIndex:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (index > self.count) { // 数组越界 - insert的时候 index 可以等于数组数量
        NSAssert(NO, @"数组越界了,xm_insertObject_NSArrayM"); // NSAssert 只有开发的时候才会造成程序崩了
    } else { // 没越界
        if (obj) { // 不为空
            [self xm_insertObject_NSArrayM:obj atIndex:index];
        } else {
            // NSAssert 只有开发的时候才会造成程序崩溃，方便调试解决问题
            NSAssert(NO, @"尝试插入 nil :xm_insertObject_NSArrayM");
        }
    }
}


@end
