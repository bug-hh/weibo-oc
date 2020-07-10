//
//  OAuthViewController.m
//  weibo-oc
//
//  Created by 彭豪辉 on 2020/7/4.
//  Copyright © 2020 bughh. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <SVProgressHUD.h>

#import "OAuthViewController.h"
#import "NetworkTools.h"
#import "UserAccount.h"
#import "UserAccountViewModel.h"


@interface OAuthViewController () <WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation OAuthViewController

#pragma mark - 懒加载 webview
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
    }
    return _webView;
}

- (void)loadView {
    self.view = self.webView;
    // 设置导航栏
    self.navigationItem.title = @"登录新浪微博";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"自动填充" style:UIBarButtonItemStylePlain target:self action:@selector(autoFill)];

}

- (void)close {
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)autoFill {
    NSLog(@"autoFill");
    NSString *js1 = @"document.getElementById('userId').value = '13167302688';";
    NSString *js2 = @"document.getElementById('passwd').value = 'phh!!0905'";
    NSString *script = [NSString stringWithFormat:@"%@%@", js1, js2];
    [self.webView evaluateJavaScript:script completionHandler:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.navigationDelegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:NetworkTools.sharedTools.oauthURL]];
    [self.webView loadRequest:request];
}

#pragma mark - WKNavigationDelegate 代理方法
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 先判断 host 是否为给定的回调地址
    if (!(webView.URL.host && [webView.URL.host isEqualToString:@"bug-hh.github.io"])) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    // 再判断 query 里面有没有 code 参数，因为用户可能点击「取消授权」
    if (!(webView.URL.query && [webView.URL.query hasPrefix:@"code="])) {
        NSLog(@"用户取消了授权");
        [self close];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    // 获取授权码
    NSString *query = webView.URL.query;
    NSString *code = [query substringFromIndex:5];
    // 根据授权码，获取 accessToken
    NSLog(@"code = %@", code);
    [UserAccountViewModel.sharedViewModel loadAccessTokenWithCode:code andFinish:^(bool isSuccessed) {
        if (isSuccessed) {
            NSLog(@"获取授权码成功");
            NSLog(@"%@", UserAccountViewModel.sharedViewModel.userAccount);
        } else {
            NSLog(@"获取授权码失败");
        }
    }];
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
