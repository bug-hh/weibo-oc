//
//  StatusListViewModel.h
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatusListViewModel : NSObject

@property (strong, nonatomic) NSArray *statusList;
@property (assign, nonatomic) int pullDownCount;

- (void)loadStatus:(void(^)(BOOL isSuccessed))finished;
@end

NS_ASSUME_NONNULL_END
