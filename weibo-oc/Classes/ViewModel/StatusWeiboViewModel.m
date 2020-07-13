//
//  StatusWeiboViewModel.m
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "StatusWeiboViewModel.h"
#import "NSDate+Extension.h"

// 单条微博数据视图模型
@implementation StatusWeiboViewModel

- (instancetype)initWithStatus:(Status *)status {
    if (self = [super init]) {
        self.status = status;
    }
    return self;
}

- (NSURL *)userIconUrl {
    if (!_userIconUrl) {
        NSString *url = self.status.user.profile_image_url;
        _userIconUrl = [NSURL URLWithString:url ? url : @""];
    }
    return _userIconUrl;
}

- (UIImage *)defaultIconImage {
    if (!_defaultIconImage) {
        _defaultIconImage = [UIImage imageNamed:@"avatar_default_big"];
    }
    return _defaultIconImage;
}

- (UIImage *)userMemberIcon {
    NSNumber *rank = self.status.user.mbrank;
    if (rank.intValue >= 0 && rank.intValue < 7) {
        NSString *name = [NSString stringWithFormat:@"common_icon_membership_level%d", rank.intValue];
        return [UIImage imageNamed:name];
    }
    return nil;
}

- (UIImage *)userVipIcon {
    int userType = self.status.user.verified_type.intValue;
    switch (userType) {
        case 0:
            return [UIImage imageNamed:@"avatar_vip"];
        case 2:
        case 3:
        case 5:
            return [UIImage imageNamed:@"avatar_enterprise_vip"];
        case 220:
            return [UIImage imageNamed:@"avatar_grassroot"];
        default:
            return nil;
    }
}

- (NSString *)created_at {
    return [[NSDate sinaDateWithString:self.status.created_at] getDateDescription];
}

- (NSString *)description
{
    return self.status.description;
}

@end

