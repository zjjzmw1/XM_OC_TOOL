//
//  UIView+XMRotate360.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/12.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "UIView+XMRotate360.h"

@implementation UIView (XMRotate360)

- (void)xmRotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount timingMode:(enum XMRotate360TimingMode)aMode {
    [self stopRotateAnimation_XM];
    CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
    theAnimation.values = [NSArray arrayWithObjects:
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,0,1)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3.13, 0,0,1)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6.26, 0,0,1)],
                           nil];
    theAnimation.cumulative = YES;
    theAnimation.duration = aDuration;
    theAnimation.repeatCount = aRepeatCount;
    theAnimation.removedOnCompletion = YES;
    
    if (aMode == XMRotate360TimingModeEaseInEaseOut) {
        theAnimation.timingFunctions = [NSArray arrayWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                        nil
                                        ];
    }
    [self.layer addAnimation:theAnimation forKey:@"transform"];
}

- (void)xmRotate360WithDuration:(CGFloat)aDuration timingMode:(enum XMRotate360TimingMode)aMode {
    [self xmRotate360WithDuration:aDuration repeatCount:1 timingMode:aMode];
}

- (void)xmRotate360WithDuration:(CGFloat)aDuration {
    [self xmRotate360WithDuration:aDuration repeatCount:1 timingMode:XMRotate360TimingModeEaseInEaseOut];
}

/// 停止旋转动画
- (void)stopRotateAnimation_XM {
    [self.layer removeAnimationForKey:@"transform"];
}

@end
