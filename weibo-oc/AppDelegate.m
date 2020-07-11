//
//  AppDelegate.m
//  weibo-oc
//
//  Created by bughh on 2020/7/2.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "UserAccountViewModel.h"
#import "NewFeatureViewController.h"
#import "WelcomeViewController.h"

@interface AppDelegate ()

@property(assign, nonatomic) BOOL isNewVersion;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupAppearance];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
//    self.window.rootViewController = [[MainViewController alloc] init];
    self.window.rootViewController = [self defaultRootViewController];
    [self.window makeKeyAndVisible];
    
    // 添加监听
    __block AppDelegate* tempSelf = self;
    [NSNotificationCenter.defaultCenter addObserverForName:WBSwitchRootViewControllerNotification  // 通知名称，通知中心用来识别通知
                                                    object:nil  // 发送通知的对象，如果为 nil，则监听所有对象
                                                     queue:nil  // 如果为 nil，那么 queue 就用主线程
                                                usingBlock:^(NSNotification * _Nonnull note) {
        UIViewController *vc = note.object ? [[WelcomeViewController alloc] init] : [[MainViewController alloc] init];
        tempSelf.window.rootViewController = vc;
    }];
    
    return YES;
}

// 这个地方，可以不写，因为 AppDelegate 只有在程序完全结束的时候才调用 dealloc，如果程序完全结束了，那么所有的监听也就不存在了。
// 写得原因，是养成良好的编程习惯，有添加监听，就有移除监听
- (void)dealloc
{
    // 移除监听
    [NSNotificationCenter.defaultCenter removeObserver:self   // 监听者
                                                  name:WBSwitchRootViewControllerNotification  // 监听的通知
                                                object:nil];  // 发送通知的对象
}

#pragma mark - 设置全局外观
// 设置全局外观，在很多应用程序中，都会在 AppDelegate 中设置所有控件的全局外观
- (void)setupAppearance {
    //        修改导航栏的全局外观，要在控件创建之前设置，一经设置，全局有效
    UINavigationBar.appearance.tintColor = WBAppearanceTintColor;
    UITabBar.appearance.tintColor = WBAppearanceTintColor;
    
}

#pragma mark 启动的根视图控制器
- (UIViewController*)defaultRootViewController {
    // 1、判断是否登录
    if (UserAccountViewModel.sharedViewModel.userLogin) {
        return self.isNewVersion ? [[NewFeatureViewController alloc] init] : [[WelcomeViewController alloc] init];
    }
    // 2、没有登录，返回主控制器
    return [[MainViewController alloc] init];
}

#pragma mark - 判断新版本
- (BOOL)isNewVersion {
    NSString *currentVersion = NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"];
    double version = currentVersion.doubleValue;
    NSLog(@"当前版本: %f", version);
    // 获取本地存储版本
    NSString *sandBoxVersionKey = @"SANDBOX_VERSION_KEY";
    double sandBoxVersion = [NSUserDefaults.standardUserDefaults doubleForKey:sandBoxVersionKey];
    NSLog(@"沙盒版本: %f", sandBoxVersion);
    //保存当前版本
    [NSUserDefaults.standardUserDefaults setObject:currentVersion forKey:sandBoxVersionKey];
    return version > sandBoxVersion;
}

#pragma mark - UISceneSession lifecycle

//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}
//

@end
