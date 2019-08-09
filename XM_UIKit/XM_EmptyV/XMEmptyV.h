//
//  XMEmptyV.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/16.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// vc页面没数据的空视图展示
@interface XMEmptyV : UIView

/// 上面一行的提示文字 - 例如：“数据加载失败”
@property (nonatomic, strong) UILabel       *tipLbl;
/// 下面一行的点击重试的文字 - 例如："点击重试"
@property (nonatomic, strong) UILabel       *retryLbl;

/// 刷新数据
- (void)refreshTipStr:(NSString *)tipStr retryStr:(NSString *)retryStr;

@end

NS_ASSUME_NONNULL_END
