//
//  XMLabel.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/12.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMLabel : UILabel

/// 文字距离边框的距离
@property(nonatomic, assign) UIEdgeInsets edgeInsets;
/// 刷新文字展示
- (void)sizeToFitWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
