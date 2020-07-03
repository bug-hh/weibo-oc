//
//  VisitorView.m
//  weibo-oc
//
//  Created by bughh on 2020/7/3.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "VisitorView.h"

@interface VisitorView ()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UIImageView *maskImageView;
@property (strong, nonatomic) UIImageView *homeImageView;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIButton *registerButton;
@property (strong, nonatomic) UIButton *loginButton;

@end
// 访客视图，处理用户未登录时的显示
@implementation VisitorView

#pragma mark 懒加载访客视图子控件
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"visitordiscover_feed_image_smallicon"]];
    }
    return _iconView;
}

- (UIImageView *)maskImageView {
    if (!_maskImageView) {
        _maskImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"visitordiscover_feed_mask_smallicon"]];
    }
    return _maskImageView;
}

- (UIImageView *)homeImageView {
    if (!_homeImageView) {
        _homeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"visitordiscover_feed_image_house"]];
    }
    return _homeImageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.text = @"关注一些人，回这里看看有什么惊喜";
        _textLabel.textColor = [UIColor blackColor];
        [_textLabel sizeToFit];
    }
    return _textLabel;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [[UIButton alloc] init];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setBackgroundImage:[UIImage imageNamed:@"common_button_white_disable"] forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_registerButton sizeToFit];
    }
    return _registerButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"common_button_white_disable"] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_loginButton sizeToFit];
    }
    return _registerButton;
}

#pragma mark 重写构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark 设置界面
- (void)setupUI {
    [self addSubview:self.iconView];
//    [self addSubview:self.maskImageView];
    [self addSubview:self.homeImageView];
    [self addSubview:self.textLabel];
    [self addSubview:self.registerButton];
    [self addSubview:self.loginButton];
    
    [self appleNativeLayout];
}

- (void)appleNativeLayout {
    for (UIView *v in self.subviews) {
        v.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // 设置圆圈
    NSLayoutConstraint *iconConX = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];

    NSLayoutConstraint *iconConY = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-60];

    [self addConstraint:iconConX];
    [self addConstraint:iconConY];
    
    // 设置小房子
    NSLayoutConstraint *homeConX = [NSLayoutConstraint constraintWithItem:self.homeImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];

    NSLayoutConstraint *homeConY = [NSLayoutConstraint constraintWithItem:self.homeImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-60];
    
    [self addConstraint:homeConX];
    [self addConstraint:homeConY];
    
    // 设置文字
    NSLayoutConstraint *textConX = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];

    NSLayoutConstraint *textTop = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:36];

    // 在 oc 里加上这个宽度约束，会崩溃，但在 swift 中不会
    NSLayoutConstraint *textWidth = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:300];

    [self addConstraint:textConX];
    [self addConstraint:textTop];
    [self addConstraint:textWidth];
    
    // 设置注册按钮
    NSLayoutConstraint *registerLeft = [NSLayoutConstraint constraintWithItem:self.registerButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];

    NSLayoutConstraint *registerTop = [NSLayoutConstraint constraintWithItem:self.registerButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:16];
    
    NSLayoutConstraint *registerWidth = [NSLayoutConstraint constraintWithItem:self.registerButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    
    NSLayoutConstraint *registerHeight = [NSLayoutConstraint constraintWithItem:self.registerButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];

    [self addConstraint:registerLeft];
    [self addConstraint:registerTop];
    [self addConstraint:registerWidth];
    [self addConstraint:registerHeight];
    
    // 设置登录按钮
//    NSLayoutConstraint *loginRight = [NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];

    NSLayoutConstraint *loginTop = [NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:16];
//
    NSLayoutConstraint *loginWidth = [NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    NSLayoutConstraint *loginHeight = [NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
////
//    [self addConstraint:loginRight];
    [self addConstraint:loginTop];
    [self addConstraint:loginWidth];
    [self addConstraint:loginHeight];
    
    // 设置遮罩
//    NSLayoutConstraint *maskLeft = [NSLayoutConstraint constraintWithItem:self.maskImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
//
//    NSLayoutConstraint *maskRight = [NSLayoutConstraint constraintWithItem:self.maskImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
//
//    NSLayoutConstraint *maskTop = [NSLayoutConstraint constraintWithItem:self.maskImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:16];
//
//    NSLayoutConstraint *maskBottom = [NSLayoutConstraint constraintWithItem:self.maskImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.registerButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-40];
//
//    [self addConstraint:maskLeft];
//    [self addConstraint:maskRight];
//    [self addConstraint:maskTop];
//    [self addConstraint:maskBottom];
    
}


@end
