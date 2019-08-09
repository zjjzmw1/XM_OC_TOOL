//
//  UIView+XMRotate360.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/12.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 旋转动画的动画样式
enum XMRotate360TimingMode {
    XMRotate360TimingModeEaseInEaseOut, // 非匀速
    XMRotate360TimingModeLinear // 匀速
};

/// 旋转动画，可以360度不停的转
@interface UIView (XMRotate360)

/// 旋转一圈，aDuration时间  默认模式是：XMRotate360TimingModeEaseInEaseOut
- (void)xmRotate360WithDuration:(CGFloat)aDuration;
/// 旋转一圈，设置时间，模式
- (void)xmRotate360WithDuration:(CGFloat)aDuration timingMode:(enum XMRotate360TimingMode)aMode;
/// 旋转一圈的时间，是否重复旋转，旋转模式
- (void)xmRotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount timingMode:(enum XMRotate360TimingMode)aMode;

/// 停止旋转动画
- (void)stopRotateAnimation_XM;

@end

NS_ASSUME_NONNULL_END
