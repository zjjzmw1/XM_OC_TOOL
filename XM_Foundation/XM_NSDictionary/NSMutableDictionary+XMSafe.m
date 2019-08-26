//
//  NSMutableDictionary+XMSafe.m
//  艺库
//
//  Created by zhangmingwei on 2019/8/26.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "NSMutableDictionary+XMSafe.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (XMSafe)

+ (void)load {
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(xm_setObject:forKey:));
    method_exchangeImplementations(fromMethod, toMethod);
}

- (void)xm_setObject:(id)emObject forKey:(NSString *)key {
    if (emObject && key) {
        [self xm_setObject:emObject forKey:key];
    } else {
        // NSAssert 只有开发的时候才会造成程序崩溃，便于解决问题
        NSAssert(NO, @"字典尝试插入nil数据是不允许的");
    }
}

@end
