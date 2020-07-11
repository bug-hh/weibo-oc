//
//  WelcomeViewController.m
//  weibo-oc
//
//  Created by bughh on 2020/7/10.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "WelcomeViewController.h"
#import "UILabel+Convenience.h"
#import "UserAccountViewModel.h"

#import <SDWebImage.h>

@interface WelcomeViewController ()

@property(strong, nonatomic) UIImageView *bgImageView;
@property(strong, nonatomic) UIImageView *iconView;
@property(strong, nonatomic) UILabel *welcomeLabel;

@end

@implementation WelcomeViewController

#pragma mark - 懒加载控件
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ad_background"]];
    }
    return _bgImageView;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_default_big"]];
        // 设置圆角
        _iconView.layer.cornerRadius = 45;
        _iconView.layer.masksToBounds = true;
    }
    return _iconView;
}

- (UILabel *)welcomeLabel {
    if (!_welcomeLabel) {
        _welcomeLabel = [[UILabel alloc] initWithTitle:@"欢迎归来" andFontSize:18 andColor:[UIColor darkGrayColor]];
    }
    return _welcomeLabel;
}

#pragma mark - loadView
- (void)loadView {
    self.view = self.bgImageView;
    [self setupUI];
}

#pragma mark - 设置布局
- (void)setupUI {
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.welcomeLabel];
    
    for (UIView *v in self.view.subviews) {
        /*
         translatesAutoresizingMaskIntoConstraints 默认为 true，支持使用 setFrame 的方式设置控件位置
         translatesAutoresizingMaskIntoConstraints 为 false，支持使用「自动布局」来设置控件位置
         */
        v.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // 设置 iconView 布局
    NSLayoutConstraint *iconViewConX = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *iconViewBottom = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-200];
    iconViewBottom.identifier = @"iconViewBottom";
    
    NSLayoutConstraint *iconViewWidth = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90];
    NSLayoutConstraint *iconHeight = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90];

    [self.view addConstraint:iconViewConX];
    [self.view addConstraint:iconViewBottom];
    [self.view addConstraint:iconViewWidth];
    [self.view addConstraint:iconHeight];
    
    // 设置 welcome label 布局
    NSLayoutConstraint *welcomeLabelConX = [NSLayoutConstraint constraintWithItem:self.welcomeLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *welcomeLabelTop = [NSLayoutConstraint constraintWithItem:self.welcomeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:16];
    
    [self.view addConstraint:welcomeLabelConX];
    [self.view addConstraint:welcomeLabelTop];
}

#pragma mark - viewDidAppear
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSArray *cons = self.view.constraints;
    NSLayoutConstraint *updateIconViewCon = nil;
    for (NSLayoutConstraint *c in cons) {
        if ([c.identifier isEqualToString:@"iconViewBottom"]) {
            updateIconViewCon = c;
            break;
        }
    }
    updateIconViewCon.constant = -self.view.bounds.size.height + 200;
    
    self.welcomeLabel.alpha = 0;
    [UIView animateWithDuration:3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:0 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0 animations:^{
            self.welcomeLabel.alpha = 1;
        } completion:^(BOOL finished) {
            // 动画完成后，发送通知给 AppDelegate，让它切换控制器
            [NSNotificationCenter.defaultCenter postNotificationName:WBSwitchRootViewControllerNotification object:nil];
        }];
    }];
    
}
#pragma mark - viewDidLoad
// 视图加载完成之后的后续处理，通常用来设置数据
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.iconView sd_setImageWithURL:UserAccountViewModel.sharedViewModel.avatarURL placeholderImage:[UIImage imageNamed:@"avatar_default_big"] options:0];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
