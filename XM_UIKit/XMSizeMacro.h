//
//  XMSizeMacro.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#ifndef XMSizeMacro_h
#define XMSizeMacro_h

/// 屏幕高度
#define kScreenHeight_XM [UIScreen mainScreen].bounds.size.height
/// 屏幕宽度
#define kScreenWidth_XM [UIScreen mainScreen].bounds.size.width

/// 比例系数 -- 以iPhone6为标准 - 传入iPhone6手机的 view的宽度或者高度 -- 就应该以宽度的比例，不应该用高度的比例
#define kScaleIphone6_W_XM(w)       (kScreenWidth_XM*(w)/375)

/// 状态栏高度
#define kStatusBarHeight_XM [[UIApplication sharedApplication] statusBarFrame].size.height
/// 导航栏+状态栏 /// 如果是iOS12以上的iPad，导航栏就是50 + status  ，ipad的导航栏不好确定，不同iPad高度也不同
#define kNaviStatusBarH_XM (kStatusBarHeight_XM + [UIViewController myNaviHeightAction])

#define kTabBarH_XM   (kIsIPhoneXSize_XM ? 83.f : (kIsIpad_XM ? 56.f : 49.f))
#define kView_bottom_h_XM  (kIsIPhoneXSize_XM ? 34.0 : 0)

/// 当前系统的版本 例如： 9.0/10.0等 float 类型
#define kCurrent_system_version_float_XM    [[[UIDevice currentDevice] systemVersion] floatValue]

/// 是否是iPhoneX的尺寸大小
#define kIsIPhoneXSize_XM ([UIScreen mainScreen].bounds.size.height == 812.0f || [UIScreen mainScreen].bounds.size.height == 896.0f)

/// 是否是iPhone4的尺寸大小
#define kIsIPhone4Size_XM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
/// 是否是kIsIPhone5Size_XM的尺寸大小
#define kIsIPhone5Size_XM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
/// 是否是iPhone6的尺寸大小
#define kIsIPhone6Size_XM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
/// 是否是iPhone6Plus的尺寸大小
#define kIsIPhone6PlusSize_XM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
/// 是否是iPad
#define kIsIpad_XM (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#define kIs_iOS10_XM    ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)
#define kIs_iOS11_XM    ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)
#define kIs_iOS12_XM    ([[UIDevice currentDevice].systemVersion doubleValue] >= 12.0)
#define kIs_iOS13_XM    ([[UIDevice currentDevice].systemVersion doubleValue] >= 13.0)
#define kIs_iOS14_XM    ([[UIDevice currentDevice].systemVersion doubleValue] >= 13.0)

#endif /* XMSizeMacro_h */
