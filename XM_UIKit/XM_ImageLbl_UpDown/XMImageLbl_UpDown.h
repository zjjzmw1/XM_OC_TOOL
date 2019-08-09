//
//  XMImageLbl_UpDown.h
//  艺库
//
//  Created by zhangmingwei on 2019/8/8.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 上面图片，下面文字的控件。类似：《tabbar》或者《一个图标下面一个标题的控件》。 默认：下面label的高度是20，下对齐。这样比较美观。 可以根据自己的需求 调用：刷新方法更新
@interface XMImageLbl_UpDown : UIView

/// 上面图片
@property (nonatomic, strong) UIImageView   *topImgV;
/// 下面标题
@property (nonatomic, strong) UILabel       *bottomLbl;

/// 刷新图片大小 imgSize  底部lbl和上边img的间隙 space
- (void)refreshImgSize:(CGSize)imgSize imageLblSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
