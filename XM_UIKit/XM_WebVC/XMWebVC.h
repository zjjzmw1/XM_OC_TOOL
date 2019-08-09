//
//  XMWebVC.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 统一的 webViewController 这里可以继承您的BaseViewController
@interface XMWebVC : UIViewController

/// 网络的urlStr
@property (nonatomic, strong) NSString      *urlStr;
/// 网页标题
@property (nonatomic, strong) NSString      *titleStr;

@end

NS_ASSUME_NONNULL_END
