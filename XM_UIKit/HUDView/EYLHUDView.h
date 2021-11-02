//
//  EYLHUDView.h
//  FastShake
//
//  Created by zhangmingwei on 2021/10/28.
//  Copyright © 2021 Eyolo Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 通用的 toast 提示
@interface EYLHUDView : UIView

/// 弹出存文字 toast 「默认1.5s后消失，文字长的话，会适当延迟消失时间」
+ (void)showTextHud:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
