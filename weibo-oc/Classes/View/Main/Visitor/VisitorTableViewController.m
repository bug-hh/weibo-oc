//
//  VisitorTableViewController.m
//  weibo-oc
//
//  Created by bughh on 2020/7/3.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "VisitorTableViewController.h"
#import "VisitorView.h"
#import "OAuthViewController.h"

@interface VisitorTableViewController ()

@property (assign, nonatomic) BOOL isUserLogin;

@end

@implementation VisitorTableViewController

- (instancetype)init {
    if (self = [super init]) {
        self.isUserLogin = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadView {
    // 根据用户的登录情况，来决定显示根视图
    self.isUserLogin ? [super loadView] : [self setupVisitorView];
}

#pragma mark 设置访客视图
- (void)setupVisitorView {
    self.visitorView = [[VisitorView alloc] init];
    self.visitorView.delegate = self;
    self.view = self.visitorView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(visitorViewDidRegistser)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem  alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(visitorViewDidLogin)];
}

#pragma mark - VisitorView 代理方法
- (void)visitorViewDidLogin {
    NSLog(@"登录");
    OAuthViewController *oauth = [[OAuthViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:oauth];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)visitorViewDidRegistser {
    NSLog(@"注册");
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


@end
