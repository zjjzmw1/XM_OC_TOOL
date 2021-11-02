//
//  EYLCustomNaviView.m
//  FastShake
//
//  Created by zhangmingwei on 2021/10/27.
//  Copyright © 2021 Eyolo Network Technology Co., Ltd. All rights reserved.
//

#import "EYLCustomNaviView.h"

@implementation EYLCustomNaviView

/**
 获取自定义导航栏
 */
+ (instancetype)getInstanceWithTitle:(nullable NSString *)titleStr {
    EYLCustomNaviView *naviV = [[EYLCustomNaviView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight)];
    [naviV setTitleStr:titleStr];
    return naviV;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    kWeakSelf
    self.backgroundColor = [UIColor whiteColor];
    // 返回按钮
    self.backBtn = [UIButton buttonWithTitle:@"" titleColor:[UIColor blackColor] font:kFont(15)];
    self.backBtn.frame = CGRectMake(0, kStatusBarHeight, 60 , kNavBarHeight - kStatusBarHeight);
    // 扩大点击区域
    [self.backBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [self.backBtn setImage:kImage(@"blackback") forState:UIControlStateNormal];
    [self addSubview:self.backBtn];
    [self.backBtn setTapActionWithBlock:^{
        if (weakSelf.backBlock) {
            weakSelf.backBlock();
        } else { // 不写的话，默认pop出去
            [[LZLTools getCurrentVC].navigationController popViewControllerAnimated:YES];
        }
    }];
    // 标题
    self.titleLbl = [UILabel labelWithTitle:@"" font:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium] textColor:[UIColor colorWithHexString:@"#000000"] alignment:NSTextAlignmentCenter];
    // 这里如果用masnory，具体使用该类的地方，就不能再使用frame了，使用的时候就不那么灵活了。
    self.titleLbl.frame = CGRectMake(75, kStatusBarHeight, kScreenWidth - 150, kNavBarHeight - kStatusBarHeight);
    [self addSubview:self.titleLbl];
    // 右边按钮
    self.rightBtn = [UIButton buttonWithTitle:@"" titleColor:[UIColor blackColor] font:kFont(15)];
    self.rightBtn.frame = CGRectMake(kScreenWidth - 60, kStatusBarHeight, 60 , kNavBarHeight - kStatusBarHeight);
    self.rightBtn.hidden = YES;
    // 扩大点击区域
    [self.rightBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [self addSubview:self.rightBtn];
    [self.rightBtn setTapActionWithBlock:^{
        if (weakSelf.rightBlock) {
            weakSelf.rightBlock();
        }
    }];
    return self;
}

/// 设置标题
- (void)setTitleStr:(nullable NSString *)titleStr {
    self.titleLbl.text = titleStr;
}

/// 设置返回按钮的  图片和标题
- (void)setBackBtnImage:(nullable UIImage *)img title:(nullable NSString *)titleStr {
    [self.backBtn setImage:img forState:UIControlStateNormal];
    [self.backBtn setTitle:titleStr forState:UIControlStateNormal];
}

/// 设置右边按钮的  图片和标题
- (void)setRightBtnImage:(nullable UIImage *)img title:(nullable NSString *)titleStr {
    [self.rightBtn setImage:img forState:UIControlStateNormal];
    [self.rightBtn setTitle:titleStr forState:UIControlStateNormal];
    if (img || ![NSString isEmptyString:titleStr]) {
        self.rightBtn.hidden = NO; // 显示右边按钮
    } else {
        self.rightBtn.hidden = YES; // 隐藏
    }
}

@end
