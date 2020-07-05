//
//  UserAccount.h
//  weibo-oc
//
//  Created by bughh on 2020/7/5.
//  Copyright © 2020 bughh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserAccount : NSObject <NSCoding>

@property(copy, nonatomic) NSString* access_token;
@property(assign, nonatomic) NSTimeInterval expires_in;
@property(assign, nonatomic) NSTimeInterval remind_in;
@property(copy, nonatomic, nullable) NSString* uid;
@property(strong, nonatomic, nullable) NSDate* expireDate;
@property(copy, nonatomic, nullable) NSString* screen_name;
@property(copy, nonatomic, nullable) NSString* avatar_large;

- (instancetype)initWithDict:(NSDictionary*)dict;
- (void)saveUserAccount;

@end

NS_ASSUME_NONNULL_END
