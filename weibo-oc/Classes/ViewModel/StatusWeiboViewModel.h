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
@property(strong, nonatomic) NSURL *userIconUrl;
@property(strong, nonatomic) UIImage *defaultIconImage;
@property(strong, nonatomic) UIImage *userMemberIcon;
@property(strong, nonatomic) UIImage *userVipIcon;
@property(copy, nonatomic) NSString *created_at;


- (instancetype)initWithStatus:(Status*)status;

@end

NS_ASSUME_NONNULL_END
