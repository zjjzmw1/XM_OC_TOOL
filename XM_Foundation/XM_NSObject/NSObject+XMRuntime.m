//
//  NSObject+XMRuntime.m
//  艺库
//
//  Created by zhangmingwei on 2019/8/26.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "NSObject+XMRuntime.h"

@implementation NSObject (XMRuntime)

/// 获取协议的列表
+ (void)getProtocolList_XM {
    unsigned int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Protocol *pro = protocolList[i];
        const char *proName = protocol_getName(pro);
        XMLog(@"proName = %@",[NSString stringWithUTF8String:proName]);
    }
}

/// 方法交互
- (void)xm_swizzleMethod:(SEL)originSelector swizzledSelector:(SEL)swizzleSelector {
    Class class = [self class];
    // 源方法
    Method originM = class_getInstanceMethod(class, originSelector);
    // 要交互的方法
    Method swizzleM = class_getInstanceMethod(class, swizzleSelector);
    
    BOOL didAddMethod = class_addMethod(class, originSelector, method_getImplementation(swizzleM), method_getTypeEncoding(swizzleM));
    // 如果 YES 证明之前的originSelector不存在，会给类添加一个方法originalSelector
    if (didAddMethod) {
        class_replaceMethod(class, swizzleSelector, method_getImplementation(originM), method_getTypeEncoding(originM));
    } else { // 之前有originSelector方法
        method_exchangeImplementations(originM, swizzleM);
    }
}

/// 方法交互 -- 类方法
+ (void)xm_class_swizzleMethod:(SEL)originSelector swizzledSelector:(SEL)swizzleSelector {
    Class class = [self class];
    // 源方法
    Method originM = class_getInstanceMethod(class, originSelector);
    // 要交互的方法
    Method swizzleM = class_getInstanceMethod(class, swizzleSelector);
    
    BOOL didAddMethod = class_addMethod(class, originSelector, method_getImplementation(swizzleM), method_getTypeEncoding(swizzleM));
    // 如果 YES 证明之前的originSelector不存在，会给类添加一个方法originalSelector
    if (didAddMethod) {
        class_replaceMethod(class, swizzleSelector, method_getImplementation(originM), method_getTypeEncoding(originM));
    } else { // 之前有originSelector方法
        method_exchangeImplementations(originM, swizzleM);
    }
}

@end
