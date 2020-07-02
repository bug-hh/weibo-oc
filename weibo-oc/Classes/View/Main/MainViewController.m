//
//  MainViewController.m
//  weibo-oc
//
//  Created by bughh on 2020/7/2.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "MainViewController.h"
#import "HomeTableViewController.h"
#import "MessageTableViewController.h"
#import "DiscoveryTableViewController.h"
#import "ProfileTableViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) UIButton *composeButton;

@end

@implementation MainViewController

// 懒加载 compose button
- (UIButton *)composeButton {
    if (!_composeButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        // 根据图片调整大小
        [button sizeToFit];
        _composeButton = button;
    }
    
    return _composeButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加控制器，并不会添加 tabbar 中的按钮，因为控件时懒加载的，所有控件都是延迟创建的
    [self addAllChildVC];
    [self setupComposedButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 把「发微博」按钮放到最前面
    [self.tabBar bringSubviewToFront:self.composeButton];
}

- (void)setupComposedButton {
    // 添加 button
    [self.tabBar addSubview:self.composeButton];
    CGFloat w = self.tabBar.bounds.size.width / (CGFloat)self.childViewControllers.count;
    CGFloat h = self.tabBar.bounds.size.height;
    // 下面两种方法都可以
    self.composeButton.frame = CGRectMake(2 * w, 0, w, h);
//    self.composeButton.frame = CGRectInset(self.tabBar.bounds, 2 * w, 0);
}

- (void)addAllChildVC {
    // 设置 tintColor - 图片渲染颜色, 如果在 AppDelegate 里设置了全局渲染，那么这里就不用渲染了
    // 性能提升技巧 - 如果能用颜色解决，就不建议使用图片
    self.tabBar.tintColor = [UIColor orangeColor];
    [self addChildVC:[[HomeTableViewController alloc] init] withTitle:@"首页" withImageName:@"tabbar_home"];
    [self addChildVC:[[MessageTableViewController alloc] init] withTitle:@"消息" withImageName:@"tabbar_message_center"];
    // 添加一个空白占位 controller 到 tab bar 中
    [self addChildViewController:[[UIViewController alloc] init]];
    [self addChildVC:[[DiscoveryTableViewController alloc] init] withTitle:@"发现" withImageName:@"tabbar_discover"];
    [self addChildVC:[[ProfileTableViewController alloc] init] withTitle:@"我的" withImageName:@"tabbar_profile"];
}

/*
 在 swift 里面，是可以通过 extension 实现对系统方法 addChildViewController 的重载，但是 oc 不支持方法重载
 */
- (void)addChildVC:(UIViewController*)controller withTitle:(NSString*)title withImageName:(NSString*)imageName {
    // 设置标题，这个标题是由内至外设置的
    /*
     最外层 tab bar controller  然后  nav controller  最后 Home controller，
     那么给 home controller 设置标题后，同样会「从内至外」给其他控制器设置，比如 tab bar controller 底部标题
     */
    controller.title = title;
    // 设置图像
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    // 导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
}

@end
