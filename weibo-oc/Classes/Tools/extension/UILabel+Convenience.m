//
//  UILabel+Convenience.m
//  weibo-oc
//
//  Created by 彭豪辉 on 2020/7/4.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "UILabel+Convenience.h"

@implementation UILabel (Convenience)

- (instancetype)initWithTitle:(NSString*)title andFontSize:(CGFloat)fontSize andColor:(UIColor*)color screenInset:(CGFloat)screenInset {
    if (self = [super init]) {
        self.text = title;
        self.textColor = color;
        self.numberOfLines = 0;
        self.font = [UIFont systemFontOfSize:fontSize];
        if (screenInset == 0) {
            self.textAlignment = NSTextAlignmentCenter;
        } else {
            // 通过指定 preferredMaxLayoutWidth 属性，给 label 的文字换行
            self.preferredMaxLayoutWidth = UIScreen.mainScreen.bounds.size.width - 2 * screenInset;
            self.textAlignment = NSTextAlignmentLeft;
        }
        [self sizeToFit];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString*)title andFontSize:(CGFloat)fontSize andColor:(UIColor*)color {
    return [self initWithTitle:title andFontSize:fontSize andColor:color screenInset:0];
}



@end
