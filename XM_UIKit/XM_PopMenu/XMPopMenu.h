//
//  XMPopMenu.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/22.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , XMPopMenuType) {
    XMPopMenuTypeDefault = 0,
    XMPopMenuTypeDark
};
/// 点击某一行的block回调
typedef void (^ClickRowBlock_XM)(int selectRow);

NS_ASSUME_NONNULL_BEGIN

/*
 用法：
 第一步：初始化+弹出
 第二步：点击回调
 例如：
    XMPopMenu *popV = [XMPopMenu showRelyOnView:rightV titles:@[@"扫一扫",@"添加好友",@"通讯录"]  icons:@[@"icon1",@"icon2",@"icon3"] menuWidth:120 isShowTriangle:YES];
    popV.clickBlock = ^(int selectRow) {
    NSLog(@"点击了第 %d 行",selectRow);
    };
 // 其他属性和方法，是为了自定义。
 */
/// 类似微信、QQ点击右上角弹出的view（带扫一扫、加好友功能的view）
@interface XMPopMenu : UIView

/// 第一步:  ---- 初始化方法一： 在指定位置弹出类方法 - 初始化和弹出合并 arrowLeft: 0 就是默认居中
+ (instancetype)showAtPoint:(CGPoint)point titles:(NSArray *)titles icons:(NSArray *)icons menuWidth:(CGFloat)itemWidth isShowTriangle:(BOOL)isShowTriangle arrowLeft:(CGFloat)arrowLeft;

/// 第一步:  ----  初始化方法二：依赖指定view弹出类方法 - 初始化弹出合并 arrowLeft: 0 就是默认居中
+ (instancetype)showRelyOnView:(UIView *)view titles:(NSArray *)titles icons:(NSArray *)icons menuWidth:(CGFloat)itemWidth isShowTriangle:(BOOL)isShowTriangle arrowLeft:(CGFloat)arrowLeft;
/// 第二步:  ---- 点击回调方法： 点击某一行的回调，返回行的下标
@property (nonatomic, copy) ClickRowBlock_XM  clickBlock;

// ----------------------------------- 自定义的时候需要 BEGIN -------------------------------------------
///  圆角半径 Default is 5.0
@property (nonatomic, assign) CGFloat cornerRadius;
/// 是否显示阴影 Default is YES
@property (nonatomic, assign , getter=isShadowShowing) BOOL isShowShadow;
/// 是否显三角形 Default is YES
@property (nonatomic, assign , getter=isShadowShowing) BOOL isShowTriangle;
/// 选择菜单项后消失 Default is YES
@property (nonatomic, assign) BOOL dismissOnSelected;
/// 点击菜单外消失  Default is YES
@property (nonatomic, assign) BOOL dismissOnTouchOutside;
/// 设置字体大小 Default is 15
@property (nonatomic, assign) CGFloat fontSize;
/// 设置字体颜色 Default is [UIColor blackColor]
@property (nonatomic, strong) UIColor * textColor;
/// 设置偏移距离 (>= 0) Default is 0.0
@property (nonatomic, assign) CGFloat offset;
/// 设置显示模式 Default is XMPopupMenuTypeDefault
@property (nonatomic, assign) XMPopMenuType type;

/// 初始化popupMenu -- 初始化和弹出需要单独设置
- (instancetype)initWithTitles:(NSArray *)titles
                         icons:(NSArray *)icons
                     menuWidth:(CGFloat)itemWidth
                     arrowLeft:(CGFloat)arrowLeft;
/// 在指定位置弹出
- (void)showAtPoint:(CGPoint)point;
/// 依赖指定view弹出
- (void)showRelyOnView:(UIView *)view;
/// 消失的方法
- (void)dismiss;
// ----------------------------------- 自定义的时候需要 END -------------------------------------------

@end

NS_ASSUME_NONNULL_END
