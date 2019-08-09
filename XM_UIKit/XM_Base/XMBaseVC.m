//
//  XMBaseVC.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/16.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMBaseVC.h"

@interface XMBaseVC ()

@end

@implementation XMBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];

    /// 添加空View
    self.xmEmptyV = [[XMEmptyV alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.xmEmptyV];
    [self.xmEmptyV setHidden:YES];
    
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

@end
