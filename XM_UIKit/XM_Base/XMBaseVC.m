//
//  XMBaseVC.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/16.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMBaseVC.h"
#import "UIViewController+XMTool.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "NSString+XMValid.h"
#import "UIColor+XMTool.h"
#import "XMSizeMacro.h"
#import "UIImageView+XMTool.h"

@interface XMBaseVC ()

/// 导航栏底部的横线
@property (nonatomic, strong) UIImageView *myNaviBottomlineImgV;

@end

@implementation XMBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 默认导航栏显示
    [self xm_hiddenCurrenPageNavi:NO];
    /// view的坐标从0开始
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    /// 添加空View
    self.xmEmptyV = [[XMEmptyV alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.xmEmptyV];
    [self.xmEmptyV setHidden:YES];
    /// 自定义导航栏下面的横线 -- 把系统的隐藏，添加自己的横线，方便展示隐藏控制颜色等
    [self initNaviBottomLine];
    /// 键盘处理
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES; // 点击屏幕缩键盘
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;          // 展示键盘上的toolbar
    [IQKeyboardManager sharedManager].enable = YES;
}

/// 默认statusBar字体颜色为黑色，某个页面想改的话，重新这个方法就OK了
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

/// 刷新空view XMEmptyV：  tipStr 和 retryStr 都为空就隐藏，否则展示
- (void)refreshEmptyVTipStr:(NSString *)tipStr retryStr:(NSString *)retryStr {
    [self.xmEmptyV refreshTipStr:tipStr retryStr:retryStr];
    if ([NSString isEmptyString:tipStr] && [NSString isEmptyString:retryStr]) {
        [self.xmEmptyV setHidden:YES];
        [self.view sendSubviewToBack:self.xmEmptyV];
    } else {
        [self.xmEmptyV setHidden:NO];
        [self.view bringSubviewToFront:self.xmEmptyV];
    }
}

/// 添加导航栏标题
- (void)addTitleStr:(NSString *)titleStr {
    self.navigationItem.title = titleStr;
}

/// 自定义导航栏下面的横线 -- 把系统的隐藏，添加自己的横线，方便展示隐藏控制颜色等 -- 默认展示
- (void)initNaviBottomLine {
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    /// 添加导航栏底部的自定义的横线
    self.myNaviBottomlineImgV = [UIImageView getImageViewFrame:CGRectMake(0, kNaviStatusBarH_XM - kStatusBarHeight_XM - 0.5, kScreenWidth_XM, 0.5)];
    self.myNaviBottomlineImgV.backgroundColor = [UIColor getSeparatorColor_XM];
    self.myNaviBottomlineImgV.alpha = 0.8;
    self.myNaviBottomlineImgV.tag = 11;
    for (UIView *lineV in self.navigationController.navigationBar.subviews) {
        if (lineV.tag == 11) {
            [lineV removeFromSuperview];
        }
    }
    [self.navigationController.navigationBar addSubview:self.myNaviBottomlineImgV];
}

/// 隐藏横线
- (void)hideNaviBottomLine_xm {
    for (UIView *lineV in self.navigationController.navigationBar.subviews) {
        if (lineV.tag == 11) {
            lineV.backgroundColor = [UIColor clearColor];
        }
    }
}

/// 展示横线
- (void)showNaviBottomLine_xm {
    for (UIView *lineV in self.navigationController.navigationBar.subviews) {
        if (lineV.tag == 11) {
            lineV.backgroundColor = [UIColor getSeparatorColor_XM];
        }
    }
}

@end
