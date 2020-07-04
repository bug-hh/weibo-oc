//
//  UILabel+Convenience.m
//  weibo-oc
//
//  Created by 彭豪辉 on 2020/7/4.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "UILabel+Convenience.h"

@implementation UILabel (Convenience)

- (instancetype)initWithTitle:(NSString*)title andFontSize:(CGFloat)fontSize andColor:(UIColor*)color {
    if (self = [super init]) {
        self.text = title;
        self.textColor = color;
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentCenter;
        [self sizeToFit];
    }
    return self;
}

@end
