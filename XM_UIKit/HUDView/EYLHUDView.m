//
//  EYLHUDView.m
//  FastShake
//
//  Created by zhangmingwei on 2021/10/28.
//  Copyright © 2021 Eyolo Network Technology Co., Ltd. All rights reserved.
//

#import "EYLHUDView.h"

@interface EYLHUDView()

/// 内容view
@property (nonatomic, strong) UIView    *contentV;
/// 提示文字label
@property (nonatomic, strong) UILabel   *titleLbl;
/// 当前的下标
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation EYLHUDView

+ (instancetype)sharedInstance {
    static EYLHUDView *single = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[EYLHUDView alloc] init];
    });
    return single;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        if (self.superview == nil) {
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        }
        if (self.superview == nil) {
            [[UIApplication sharedApplication].windows.lastObject addSubview:self];
        }

        [self addSubview:self.contentV];
        [self addSubview:self.titleLbl];
        kWeakSelf
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf.superview);
        }];
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.lessThanOrEqualTo(kScreenWidth - 80);
            make.top.bottom.equalTo(weakSelf).inset(16);
            make.left.right.equalTo(weakSelf).inset(16);
        }];
        [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.titleLbl).offset(-16);
            make.right.equalTo(weakSelf.titleLbl).offset(16);
            make.top.equalTo(weakSelf.titleLbl).offset(-10);
            make.bottom.equalTo(weakSelf.titleLbl).offset(10);
        }];
    }
    return self;
}

/// 弹出存文字 toast
+ (void)showTextHud:(NSString *)text {
    [[EYLHUDView sharedInstance] removeFromSuperview];
    if ([NSString isEmptyString:text]) {
        return;
    }
    [EYLHUDView sharedInstance].currentIndex += 1;
    if ([EYLHUDView sharedInstance].superview == nil) {
        [[UIApplication sharedApplication].keyWindow addSubview:[EYLHUDView sharedInstance]];
    }
    if ([EYLHUDView sharedInstance].superview == nil) {
        [[UIApplication sharedApplication].windows.lastObject addSubview:[EYLHUDView sharedInstance]];
    }
    [[EYLHUDView sharedInstance] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo([EYLHUDView sharedInstance].superview);
    }];
    [EYLHUDView sharedInstance].userInteractionEnabled = NO;
    // 展示文字
    [EYLHUDView sharedInstance].titleLbl.text = text;
    // 改变行间距
    [UILabel changeLineSpaceForLabel:[EYLHUDView sharedInstance].titleLbl WithSpace:4];
    [EYLHUDView sharedInstance].titleLbl.textAlignment = NSTextAlignmentCenter;
    
    [[EYLHUDView sharedInstance] layoutIfNeeded];
    [EYLHUDView sharedInstance].contentV.layer.cornerRadius = [EYLHUDView sharedInstance].contentV.frame.size.height/2.0;
    
    float delayTime = 1.5;
    if (text.length > 10) {
        delayTime = 1.8;
    }
    if (text.length > 15) {
        delayTime = 2.3;
    }
    // 默认1.5s后隐藏
    [[EYLHUDView sharedInstance] hiddenActionAfterTime:delayTime index:[EYLHUDView sharedInstance].currentIndex];
}

/// 隐藏 toast
- (void)hiddenActionAfterTime:(float)timeSecond index:(NSInteger)index {
    // 延迟执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeSecond * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (index == [EYLHUDView sharedInstance].currentIndex) {
            [[EYLHUDView sharedInstance] removeFromSuperview];
        }
    });
}

- (UIView *)contentV {
    if (!_contentV) {
        _contentV = [[UIView alloc] init];
        _contentV.layer.masksToBounds = YES;
        _contentV.layer.cornerRadius = 8;
        _contentV.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.8];
        _contentV.alpha = 1.0;
        _contentV.userInteractionEnabled = NO;
    }
    return _contentV;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [UILabel labelWithTitle:@"" font:kFont(13) textColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
        _titleLbl.numberOfLines = 0;
    }
    return _titleLbl;
}

@end
