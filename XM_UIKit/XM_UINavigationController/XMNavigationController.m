//
//  XMNavigationController.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMNavigationController.h"

@interface XMNavigationController ()

@end

@implementation XMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/// push到其他页面的时候，自动隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        // 如果不是添加栈底的控制器才需要隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 没这句可不行，页面都展示不出了。。。。
    [super pushViewController:viewController animated:animated];
}

@end
