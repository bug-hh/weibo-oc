//
//  StatusWeiboViewModel.m
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "StatusWeiboViewModel.h"

// 单条微博数据视图模型
@implementation StatusWeiboViewModel

- (instancetype)initWithStatus:(Status *)status {
    if (self = [super init]) {
        self.status = status;
    }
    return self;
}

- (NSString *)description
{
    return self.status.description;
}

@end

