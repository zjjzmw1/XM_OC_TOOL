//
//  XMToolMacro.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#ifndef XMToolMacro_h
#define XMToolMacro_h

/// 网络断开的统一提示文字
#define kNetworkErrorTipStr_XM          @"网络连接断开,请检查网络"
/// 请求失败统一的提示文字
#define kRequestFailureTipStr_XM        @"加载失败，请稍后重试"

#ifdef DEBUG
///debug模式下-----------------Begin--------------------------
// 不能直接对NSLog重定义，否则第三方的log定义会报错
#define XMLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
///release模式下---------------End--------------------------
#define XMLog(tmt, ...)
#endif

/// 当前版本号例如：1.2.0 - 字符串类型
#define kCurrentVersionStr_XMOC [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#endif /* XMToolMacro_h */
