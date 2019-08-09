//
//  XMTextViewOC.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMTextViewOC : UITextView

///类似UITextField的默认的文字。
@property (nonatomic) NSString *placeholder;
///默认文字的颜色
@property (nonatomic) UIColor *placeholderColor;
///默认文字的大小.
@property (nonatomic, assign) float placeholerFontSize;

@end

NS_ASSUME_NONNULL_END
