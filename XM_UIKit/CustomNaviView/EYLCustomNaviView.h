//
//  EYLCustomNaviView.h
//  FastShake
//
//  Created by zhangmingwei on 2021/10/27.
//  Copyright © 2021 Eyolo Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 自定义的导航栏 View
@interface EYLCustomNaviView : UIView

/// 返回按钮点击事件  -  默认是 pop到上一页面
@property (nonatomic, copy) void (^backBlock)(void);
/// 右边按钮点击事件
@property (nonatomic, copy) void (^rightBlock)(void);

/// 返回按钮
@property (nonatomic, strong) UIButton      *backBtn;
/// 标题
@property (nonatomic, strong) UILabel       *titleLbl;
/// 右边按钮
@property (nonatomic, strong) UIButton      *rightBtn;

/**
 获取自定义导航栏
 */
+ (instancetype)getInstanceWithTitle:(nullable NSString *)titleStr;

/// 设置标题
- (void)setTitleStr:(nullable NSString *)titleStr;
/// 设置返回按钮的  图片和标题
- (void)setBackBtnImage:(nullable UIImage *)img title:(nullable NSString *)titleStr;
/// 设置右边按钮的  图片和标题
- (void)setRightBtnImage:(nullable UIImage *)img title:(nullable NSString *)titleStr;

@end

NS_ASSUME_NONNULL_END
