//
//  XMLabel.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/12.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMLabel.h"

@implementation XMLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    UIEdgeInsets insets = self.edgeInsets;
    CGRect rect         = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                            limitedToNumberOfLines:numberOfLines];
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

- (void)sizeToFitWithText:(NSString *)text {
    self.text = text;
    [self sizeToFit];
}


@end
