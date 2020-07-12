//
//  StatusWeiboViewModel.h
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Status.h"

NS_ASSUME_NONNULL_BEGIN

@interface StatusWeiboViewModel : NSObject

@property(strong, nonatomic) Status *status;

- (instancetype)initWithStatus:(Status*)status;

@end

NS_ASSUME_NONNULL_END
