//
//  UIImageView+Convenience.m
//  weibo-oc
//
//  Created by 彭豪辉 on 2020/7/4.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "UIImageView+Convenience.h"

@implementation UIImageView (Convenience)

- (instancetype)initWithImageName:(NSString *)imageName {
    return [self initWithImage:[UIImage imageNamed:imageName]];
}


@end
