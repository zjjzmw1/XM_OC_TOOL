//
//  NSObject+XMRuntime.h
//  艺库
//
//  Created by zhangmingwei on 2019/8/26.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

/// runtime便利的使用方法
@interface NSObject (XMRuntime)

/// 获取协议的列表
+ (void)getProtocolList_XM;

/// 方法交互
- (void)xm_swizzleMethod:(SEL)originSelector swizzledSelector:(SEL)swizzleSelector;

/// 方法交互 -- 类方法
+ (void)xm_class_swizzleMethod:(SEL)originSelector swizzledSelector:(SEL)swizzleSelector;

@end

NS_ASSUME_NONNULL_END
