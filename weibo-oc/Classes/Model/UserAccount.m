//
//  UserAccount.m
//  weibo-oc
//
//  Created by bughh on 2020/7/5.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "UserAccount.h"

@implementation UserAccount

- (instancetype)initWithDict:(NSDictionary*)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setExpires_in:(NSTimeInterval)expires_in {
    self.expireDate = [NSDate dateWithTimeIntervalSinceNow:self.expires_in];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description
{
    NSArray *arr = @[@"access_token", @"expireDate", @"remind_in", @"uid", @"screen_name", @"avatar_large"];
    return [[self dictionaryWithValuesForKeys:arr] description];
    
}

#pragma mark 保存用户信息
- (void)saveUserAccount {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"account.plist"];
    NSLog(@"保存用户信息：%@", path);
    BOOL ret = [NSKeyedArchiver archiveRootObject:self toFile:path];
    if (ret) {
        NSLog(@"保存成功");
    } else {
        NSLog(@"保存失败");
    }
}

#pragma mark NSCoding 协议方法
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.access_token forKey:@"access_token"];
    [coder encodeObject:self.expireDate forKey:@"expireDate"];
    [coder encodeObject:self.uid forKey:@"uid"];
    [coder encodeObject:self.screen_name forKey: @"screen_name"];
    [coder encodeObject:self.avatar_large forKey: @"avatarLarge"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self.access_token = [coder decodeObjectForKey:@"access_token"];
    self.expireDate = [coder decodeObjectForKey:@"expireDate"];
    self.uid = [coder decodeObjectForKey:@"uid"];
    self.screen_name = [coder decodeObjectForKey:@"screen_name"];
    self.avatar_large = [coder decodeObjectForKey:@"avatar_large"];
    return self;
}

@end
