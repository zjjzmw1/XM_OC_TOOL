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

/// 语言判断：-------- 语言是否是中文 BOOL ---------------
#define kLanguage_Is_Chinese_XM          ([([[NSLocale preferredLanguages] objectAtIndex:0]) == nil ? @"" : ([[NSLocale preferredLanguages] objectAtIndex:0]) hasPrefix:@"zh"])
/// 语言判断：-------- 语言是否是英文。英语：YES 其他语言：NO
#define kLanguage_Is_English_XM          ([([[NSLocale preferredLanguages] objectAtIndex:0]) == nil ? @"" : ([[NSLocale preferredLanguages] objectAtIndex:0]) hasPrefix:@"en"])

/// 地区判断：-------- 是否在中国地区包括港澳台 BOOL ---------------
#define kArea_In_China_XM \
(([kLocal_string_upper_case_XM hasSuffix:@"CN"] ||    \
[kLocal_string_upper_case_XM hasSuffix:@"HK"] ||   \
[kLocal_string_upper_case_XM hasSuffix:@"TW"] ||   \
[kLocal_string_upper_case_XM hasSuffix:@"MO"]))
/// 地区判断：-------- 是否在中国内地 (不含港澳台) BOOL ------------
#define kArea_In_China_mainland_XM         ([kLocal_string_upper_case_XM hasSuffix:@"CN"])
/// -------- 获取本地语言的字符串。例如： "ZH_CN"
// 中国-大陆    ZH_CN
// 中文-香港    ZH_HK
// 英文-香港    EN_HK
// 英文-中国    EN_CN
// 英文-台湾    EN_TW
// 英文-澳门    EN_MO
#define kLocal_string_upper_case_XM     [(NSString *)[[NSLocale currentLocale] localeIdentifier] uppercaseString]


#endif /* XMToolMacro_h */
