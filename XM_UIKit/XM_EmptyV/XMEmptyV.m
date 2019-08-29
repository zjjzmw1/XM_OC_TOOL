//
//  XMEmptyV.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/16.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMEmptyV.h"
#import "UILabel+XMTool.h"
#import "UIColor+XMTool.h"
#import "UIView+XMTool.h"
#import "XMSizeMacro.h"                 // OC 尺寸相关宏

@interface XMEmptyV()

/// 当前空页面的size
@property (nonatomic, assign) CGSize        currentSize;

@end

@implementation XMEmptyV

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.currentSize = frame.size;
    /// 用frame的方式，防止个别项目没用 masonry,或者用的其他第三方的布局。 frame通吃.
    
    self.tipLbl = [UILabel getLabelWithFont:[UIFont boldSystemFontOfSize:16] textColor:[UIColor getBlackColor_2]];
    [self addSubview:self.tipLbl];
    self.tipLbl.numberOfLines = 0;
    self.tipLbl.textAlignment = NSTextAlignmentCenter;
    
    self.retryLbl = [UILabel getLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor getRedColor_XM]];
    [self addSubview:self.retryLbl];
    self.retryLbl.numberOfLines = 0;
    self.retryLbl.textAlignment = NSTextAlignmentCenter;
    [self.retryLbl setUserInteractionEnabled:YES];
    
    return self;
}

/// 刷新数据
- (void)refreshTipStr:(NSString *)tipStr retryStr:(NSString *)retryStr {
    self.tipLbl.text = tipStr;
    self.retryLbl.text = retryStr;
    // 提示文字的位置更新
    self.tipLbl.frame = CGRectMake(15, self.currentSize.height/2.0 - kNaviStatusBarH_XM - 50 , self.frame.size.width - 30, 50);
    [self.tipLbl sizeToFit];
    self.tipLbl.centerX = self.centerX - self.left;
    // 重试文字的位置更新
    self.retryLbl.frame = CGRectMake(15, self.tipLbl.bottom + 10 , self.frame.size.width - 30, 40);
    [self.retryLbl sizeToFit];
    self.retryLbl.centerX = self.centerX - self.left;
}

@end
