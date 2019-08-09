//
//  XMWebVC.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMWebVC.h"

@interface XMWebVC ()<WKNavigationDelegate>

@property (nonatomic, strong) UIProgressView *myProgressView;
@property (nonatomic, strong) WKWebView *myWebView;

@end

@implementation XMWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myWebView];
    self.myWebView.frame = CGRectMake(0, 0, kScreenWidth_XM, kScreenHeight_XM - kNaviStatusBarH_XM);
    [self.view addSubview:self.myProgressView];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}

// 记得取消监听
- (void)dealloc {
    [self.myWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.myWebView removeObserver:self forKeyPath:@"title"];
}

#pragma mark - WKNavigationDelegate method
// 如果不添加这个，那么wkwebview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.myWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.myProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.myProgressView setProgress:0 animated:NO];
                             }];
        }
    } else if (object == self.myWebView && [keyPath isEqualToString:@"title"]) {
        if ([NSString isEmptyString:self.titleStr]) {
            self.navigationItem.title = self.myWebView.title;
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - getter and setter
- (UIProgressView *)myProgressView {
    if (_myProgressView == nil) {
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2)];
        _myProgressView.tintColor = [UIColor getRedColor_XM];
        _myProgressView.trackTintColor = [UIColor whiteColor];
    }
    
    return _myProgressView;
}

- (WKWebView *)myWebView {
    if(_myWebView == nil) {
        _myWebView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _myWebView.navigationDelegate = self;
        _myWebView.opaque = NO;
        _myWebView.multipleTouchEnabled = YES;
        [_myWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_myWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _myWebView;
}

@end
