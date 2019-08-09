//
//  UIView+XMTool.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "UIView+XMTool.h"
#import <objc/runtime.h>

static char kDTActionHandlerTapBlockKey;
static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerLongPressBlockKey;
static char kDTActionHandlerLongPressGestureKey;

@implementation UIView (XMTool)

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)top {
    return self.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left {
    return self.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right {
    return self.left + self.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    
    frame.size.height = height;
    self.frame = frame;
}


- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

//bounds accessors

- (CGSize)boundsSize {
    return self.bounds.size;
}

- (void)setBoundsSize:(CGSize)size {
    CGRect bounds = self.bounds;
    
    bounds.size = size;
    self.bounds = bounds;
}

- (CGFloat)boundsWidth {
    return self.boundsSize.width;
}

- (void)setBoundsWidth:(CGFloat)width {
    CGRect bounds = self.bounds;
    
    bounds.size.width = width;
    self.bounds = bounds;
}

- (CGFloat)boundsHeight {
    return self.boundsSize.height;
}

- (void)setBoundsHeight:(CGFloat)height {
    CGRect bounds = self.bounds;
    
    bounds.size.height = height;
    self.bounds = bounds;
}

//content getters

- (CGRect)contentBounds {
    return CGRectMake(0.0f, 0.0f, self.boundsWidth, self.boundsHeight);
}

- (CGPoint)contentCenter {
    return CGPointMake(self.boundsWidth / 2.0f, self.boundsHeight / 2.0f);
}

- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
    } while (next != nil);
    
    return nil;
}


- (void)setTapActionWithBlock:(void (^)(void))block {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void (^ action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        
        if (action) {
            action();
        }
    }
}

- (void)setLongPressActionWithBlock:(void (^)(void))block {
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerLongPressGestureKey);
    
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        void (^ action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerLongPressBlockKey);
        
        if (action) {
            action();
        }
    }
}


- (void)layoutSubviews {
    //    self.layer.frame = self.bounds;
}

/**
 *  添加UIView的四个角的任意角的圆角 需要对设置圆角的view添加frame，否则不行
 *
 *  @param angle    圆角的大小
 *  @param corners  设置哪个角为圆角
 */
- (void)addRectCorner:(float)angle corners:(UIRectCorner)corners {
    // 设置圆角，需要view有frame
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(angle, angle)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/**
 *  给View添加黑色阴影和圆角 - 四个边都有阴影  Tip~!!!!! 这种添加阴影的话，不能用高性能的圆角了。
 *
 *  @param shadowColor      阴影颜色
 *  @param corner           view的圆角
 */
- (void)addShadowWithColor:(UIColor *)shadowColor corner:(float)corner {
    if (corner > 0) { // 避免view的其他地方有圆角，这里传入0，把圆角弄没了。
        self.layer.cornerRadius = corner;
    }
    self.layer.masksToBounds = YES;             // 和下面一句的顺序不能错
    self.clipsToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 1); // 阴影的偏移 （扩散大于偏移就能达到四个边都有阴影）
    self.layer.shadowRadius = 1;                // 阴影的扩散程度
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = 0.7;           // 阴影的透明度
}

/// 创建一条横线 : 横线的frame，和颜色
+ (UIView *)getLineViewWithFrame:(CGRect)frame color:(UIColor *)color {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    return line;
}

@end
