//
//  HomeTableViewController.m
//  weibo-oc
//
//  Created by bughh on 2020/7/2.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "HomeTableViewController.h"
#import "UserAccountViewModel.h"
#import "NetworkTools.h"
#import "Status.h"
#import "StatusListViewModel.h"
#import "StatusWeiboViewModel.h"
#import "StatusCell.h"

#import <SVProgressHUD.h>

@interface HomeTableViewController ()

@property(strong, nonatomic) StatusListViewModel *listViewModel;

@end

@implementation HomeTableViewController

- (StatusListViewModel *)listViewModel {
    if (!_listViewModel) {
        _listViewModel = [[StatusListViewModel alloc] init];
    }
    return _listViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!UserAccountViewModel.sharedViewModel.userLogin && self.visitorView) {
        [self.visitorView setupInfo:nil andTitle:@"关注一些人，回这里看看有什么惊喜"];
        return;
    }
    
    [self prepareTableView];
    [self loadData];
}

#pragma mark - 加载微博数据
- (void)loadData {
    [self.listViewModel loadStatus:^(BOOL isSuccessed) {
        if (!isSuccessed) {
            [SVProgressHUD showWithStatus:@"加载数据错误，请稍后重试"];
            return;
        }
        NSLog(@"%@", self.listViewModel.statusList);
        [self.tableView reloadData];
    }];
}

#pragma mark - 准备 table view 表格数据
- (void)prepareTableView {
    // 注册可重用 cell
    [self.tableView registerClass:StatusCell.class forCellReuseIdentifier:StatusCellNormalID];
    // 临时行高
    self.tableView.rowHeight = 200;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listViewModel.statusList ? self.listViewModel.statusList.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:StatusCellNormalID forIndexPath:indexPath];
    StatusWeiboViewModel *weibo = self.listViewModel.statusList[indexPath.item];
    // 重写 cell 的 viewModel 的 setter 方法
    cell.viewModel = weibo;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
