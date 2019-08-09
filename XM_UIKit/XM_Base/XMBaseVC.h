//
//  XMBaseVC.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/16.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMEmptyV.h"

NS_ASSUME_NONNULL_BEGIN

/// 所有页面的父视图 - 可以把这里有用的属性和写法，拷贝到自己的父视图
@interface XMBaseVC : UIViewController

/// vc的空页面 -- 具体页面点击重试的时候需要用
@property (nonatomic, strong) XMEmptyV      *xmEmptyV;

/// 刷新空view XMEmptyV：  tipStr 和 retryStr 都为空就隐藏，否则展示
- (void)refreshEmptyVTipStr:(NSString *)tipStr retryStr:(NSString *)retryStr;

@end

NS_ASSUME_NONNULL_END
