
//
//  XMHeader.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#ifndef XMHeader_h
#define XMHeader_h

// Foundation 相关
#import <Foundation/Foundation.h>
#import "XMToolMacro.h"                 // OC 常用工具类宏
#import "XMTool.h"
#import "NSString+XMTool.h"
#import "NSString+XMBusiness.h"
#import "NSString+XMValid.h"
#import "NSDate+XMTool.h"
#import "NSArray+XMSafe.h"              // 防止数组越界
#import "XMTimer.h"                     // 好用的定时器管理
#import "XMLocationTrans.h"             // 坐标系转换 --百度-火星-地球
#import "XMNetworkNotificationManager.h"    // 网络监听

// UIKit 相关
#import <UIKit/UIKit.h>
#import "XMBaseVC.h"
#import "XMEmptyV.h"
#import "XMWebVC.h"
#import "XMSizeMacro.h"                 // OC 尺寸相关宏
#import "UIView+XMTool.h"
#import "UIView+XMConvertRect.h"
#import "UIView+XMRotate360.h"
#import "UIColor+XMTool.h"
#import "UILabel+XMTool.h"
#import "UIImage+XMTool.h"
#import "UIImageView+XMTool.h"
#import "UIButton+XMTool.h"
#import "UITextField+XMTool.h"
#import "XMTextViewOC.h"
#import "XMLabel.h"
#import "XMNavigationController.h"
#import "UIViewController+XMTool.h"
#import "XMTabBarVC.h"
#import "XMImageLbl_UpDown.h"
#import "UITableView+XMTool.h"
#import "YYLabel_XM.h"                  // 富文本
#import "UIScrollView+XMTool.h"

// 路由 相关
#import "XMRouterTool.h"                // OC 简单的跳转路由

/// OC的网络请求封装 - 对AFNetworking进行
#import "XMRequestManager.h"

#endif /* XMHeader_h */
