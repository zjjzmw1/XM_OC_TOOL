//
//  XMImageLbl_UpDown.m
//  艺库
//
//  Created by zhangmingwei on 2019/8/8.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMImageLbl_UpDown.h"

@implementation XMImageLbl_UpDown

/// 默认：下面label的高度是20，下对齐。这样比较美观。 可以根据自己的需求 调用：刷新方法更新
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    __weak typeof(self) wSelf = self;
    self.topImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
    self.topImgV.contentMode = UIViewContentModeScaleAspectFit; // 等比例缩放
    [self addSubview:self.topImgV];
    [self.topImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(wSelf);
        make.bottom.equalTo(wSelf).inset(20);
    }];
    
    self.bottomLbl = [UILabel getLabelWithFont:FontWithSize(14) textColor:UIColor.getBlackColor_1];
    [self addSubview:self.bottomLbl];
    self.bottomLbl.textAlignment = NSTextAlignmentCenter;
    [self.bottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf);
        make.centerX.equalTo(wSelf);
    }];
    
    return self;
}

/// 刷新图片大小 imgSize  底部lbl和上边img的间隙 space
- (void)refreshImgSize:(CGSize)imgSize imageLblSpace:(CGFloat)space {
    __weak typeof(self) wSelf = self;
    [self.topImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(wSelf);
        make.centerX.equalTo(wSelf);
        make.size.mas_equalTo(imgSize);
    }];
    if (space > 0) {
        [self.bottomLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf.topImgV.mas_bottom).offset(space);
            make.centerX.equalTo(wSelf);
        }];
    }
}


@end
