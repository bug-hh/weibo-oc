//
//  UIButton+Convenience.m
//  weibo-oc
//
//  Created by bughh on 2020/7/3.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "UIButton+Convenience.h"

@implementation UIButton (Convenience)

- (instancetype)initWithImageName:(NSString*)imageName andBackgroundImageName:(NSString*)bg {
    if (self = [super init]) {
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted", imageName]] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageNamed:bg] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted", bg]] forState:UIControlStateHighlighted];
        [self sizeToFit];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title andColor:(UIColor *)color andBgImageName:(NSString *)imageName {
    if (self = [super init]) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:color forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self sizeToFit];
    }
    return self;
}

- (instancetype)initWithForegroundImageName:(NSString *)fgName andTitle:(NSString *)title andFontSize:(CGFloat)fontSize {
    if (self = [super init]) {
        [self setImage:[UIImage imageNamed:fgName] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        [self sizeToFit];
    }
    return self;
}

@end
