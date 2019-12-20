//
//  UIViewController+XMPresentFullScreen.m
//  artreeIOS
//
//  Created by zhangmingwei on 2019/12/20.
//  Copyright © 2019 yiku. All rights reserved.
//

#import "UIViewController+XMPresentFullScreen.h"
#import <objc/runtime.h>

@implementation UIViewController (XMPresentFullScreen)

/// 全屏 UIModalPresentationFullScreen
- (void)xmPresentFullAction {
    /// 默认present 页面的时候为：全屏模式  -- 完美处理iOS13，弹出vc，不全屏的bug。
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    [self xmPresentFullAction];
}

+ (void)load {
    xm_swizzleMethod([self class], @selector(viewDidLoad), @selector(xmPresentFullAction));
}
// 自定义交换方法
void xm_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
