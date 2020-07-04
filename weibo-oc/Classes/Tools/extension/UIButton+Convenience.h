//
//  UIButton+Convenience.h
//  weibo-oc
//
//  Created by bughh on 2020/7/3.
//  Copyright © 2020 bughh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Convenience)

- (instancetype)initWithImageName:(NSString*)imageName andBackgroundImageName:(NSString*)bg;
- (instancetype)initWithTitle:(NSString *)title andColor:(UIColor *)color andBgImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
