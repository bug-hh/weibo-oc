//
//  UserAccountViewModel.m
//  weibo-oc
//
//  Created by bughh on 2020/7/5.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "UserAccountViewModel.h"
#include "NetworkTools.h"

@interface UserAccountViewModel ()

@property(copy, nonatomic) NSString *accountPath;
@property(assign, nonatomic) BOOL isExpired;

@end

@implementation UserAccountViewModel

+(instancetype)sharedViewModel {
    static UserAccountViewModel *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserAccountViewModel alloc] init];
    });
    
    return instance;
}
- (NSString *)accountPath {
    if (!_accountPath) {
        _accountPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _accountPath = [_accountPath stringByAppendingPathComponent:@"account.plist"];
    }
    return _accountPath;
}

- (BOOL)userLogin {
    return self.userAccount.access_token && !self.isExpired;
}

- (BOOL)isExpired {
    // 测试
//    self.userAccount.expireDate = [NSDate dateWithTimeIntervalSinceNow:-3600];
    return [self.userAccount.expireDate compare:[NSDate date]] == NSOrderedAscending;
}

// 返回一个有效的 token
- (NSString *)accessToken {
    if (!_isExpired) {
        return self.userAccount.access_token;
    }
    return nil;
}

- (NSURL *)avatarURL {
    return [NSURL URLWithString:self.userAccount.avatar_large ? self.userAccount.avatar_large : @""];
}

- (instancetype)init {
    if (self = [super init]) {
        self.userAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:self.accountPath];
        // 如果用户信息过期了，就清空
        if (self.isExpired) {
            NSLog(@"用户信息已过期");
            self.userAccount = nil;
        }
    }
    return self;
}

#pragma mark 获取 access token
- (void)loadAccessTokenWithCode:(NSString*)code andFinish:(void(^)(bool isSuccessed))finished {
    [NetworkTools.sharedTools accessTokenWithCode:code andFinish:^(id  _Nullable response, NSError * _Nullable error) {
        if (response) {
            NSDictionary *dict = (NSDictionary*)response;
            self.userAccount = [[UserAccount alloc] initWithDict:dict];
            [self loadUserInfoWithUserAccount:self.userAccount andFinish:finished];
        } else {
            finished(false);
        }
    }];
}

#pragma mark 获取用户信息
- (void)loadUserInfoWithUserAccount:(UserAccount*)userAccount andFinish:(void(^)(bool isSuccessed))finished {
    [NetworkTools.sharedTools loadUserInfoWithUid:userAccount.uid finish:^(id  _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"出错了");
            return;
        }
        
        NSDictionary *dict = (NSDictionary*)response;
        /*
         UserAccont 中的信息获取分成了两步，第一步在获取 access token 中，设置 access_token,expireDate,uid
         第二步，在本方法中设置 screen_name，avatar_large
         */
        userAccount.screen_name = dict[@"screen_name"];
        userAccount.avatar_large = dict[@"avatar_large"];
        
        // 保存用户账号信息
        BOOL ret = [NSKeyedArchiver archiveRootObject:userAccount toFile:self.accountPath];
        if (ret) {
            NSLog(@"保存用户信息成功");
        } else {
            NSLog(@"保存用户信息失败");
        }
        
        finished(true);
    }];
}
@end
