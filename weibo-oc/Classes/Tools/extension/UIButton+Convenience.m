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

@end
