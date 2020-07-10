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

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupAppearance];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
//    self.window.rootViewController = [[MainViewController alloc] init];
    self.window.rootViewController = [[WelcomeViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 设置全局外观
// 设置全局外观，在很多应用程序中，都会在 AppDelegate 中设置所有控件的全局外观
- (void)setupAppearance {
    //        修改导航栏的全局外观，要在控件创建之前设置，一经设置，全局有效
    UINavigationBar.appearance.tintColor = WBAppearanceTintColor;
    UITabBar.appearance.tintColor = WBAppearanceTintColor;
    
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
