//
//  VisitorView.h
//  weibo-oc
//
//  Created by bughh on 2020/7/3.
//  Copyright © 2020 bughh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Convenience.h"
#import "UILabel+Convenience.h"
#import "UIImageView+Convenience.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VisitorDelegate <NSObject>

// 注册
- (void)visitorViewDidRegistser;
// 登录
- (void)visitorViewDidLogin;

@end

@interface VisitorView : UIView

@property (weak, nonatomic) id<VisitorDelegate> delegate;

- (void)setupInfo:(NSString* __nullable)imageName andTitle:(NSString*)title;


@end

NS_ASSUME_NONNULL_END
