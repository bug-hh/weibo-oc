//
//  UILabel+Convenience.m
//  weibo-oc
//
//  Created by 彭豪辉 on 2020/7/4.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "UILabel+Convenience.h"

@implementation UILabel (Convenience)

- (instancetype)initWithTitle:(NSString*)title andColor:(UIColor*)color screenInset:(CGFloat)screenInset {
    if (self = [super init]) {
        self.text = title;
        self.textColor = color;
        self.numberOfLines = 0;
        if (screenInset == 0) {
            self.textAlignment = NSTextAlignmentCenter;
        } else {
            self.preferredMaxLayoutWidth = UIScreen.mainScreen.bounds.size.width - 2 * screenInset;
            self.textAlignment = NSTextAlignmentLeft;
        }
        [self sizeToFit];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString*)title andFontSize:(CGFloat)fontSize andColor:(UIColor*)color {
    if (self = [super init]) {
        self.font = [UIFont systemFontOfSize:fontSize];
        self.text = title;
        self.textColor = color;
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentCenter;
        [self sizeToFit];
    }
    return self;
}



@end
