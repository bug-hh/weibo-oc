//
//  UserAccountViewModel.h
//  weibo-oc
//
//  Created by bughh on 2020/7/5.
//  Copyright © 2020 bughh. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "UserAccount.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserAccountViewModel : NSObject

@property(strong, nonatomic, nullable) UserAccount *userAccount;
@property(assign, nonatomic) BOOL userLogin;
@property(copy, nonatomic, nullable) NSString* accessToken;
@property(copy, nonatomic) NSURL* avatarURL;

+ (instancetype)sharedViewModel;
- (void)loadAccessTokenWithCode:(NSString*)code andFinish:(void(^)(bool isSuccessed))finished;


@end

NS_ASSUME_NONNULL_END
