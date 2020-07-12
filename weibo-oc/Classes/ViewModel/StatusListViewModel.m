//
//  StatusListViewModel.m
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "StatusListViewModel.h"
#import "NetworkTools.h"
#import "Status.h"
#import "StatusWeiboViewModel.h"

@implementation StatusListViewModel

- (void)loadStatus:(void (^)(BOOL))finished {
    NSNumber *sinceID = [NSNumber numberWithLong:0];
    NSNumber *maxID = [NSNumber numberWithLong:0];
    [NetworkTools.sharedTools loadStatusWithSinceId:sinceID andMaxId:maxID finishCallback:^(id  _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"出错了");
            return;
        }
        NSDictionary *resp = (NSDictionary*)response;
        NSArray *arr = resp[@"statuses"];
        NSMutableArray *statusArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            StatusWeiboViewModel *weibo = [[StatusWeiboViewModel alloc] initWithStatus:[Status statusWithDict:dict]];
            [statusArr addObject:weibo];
        }

        [statusArr addObjectsFromArray:self.statusList];
        self.statusList = statusArr;
        NSLog(@"%zd", self.statusList.count);
        finished(YES);
    }];
}
@end
