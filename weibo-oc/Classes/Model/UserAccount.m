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
    // 不能写成下面这样，因为现在对象还没有创建出来，self 为 nil，会崩溃
//    self.expires_in = expires_in
    _expires_in = expires_in;
    self.expireDate = [NSDate dateWithTimeIntervalSinceNow:self.expires_in];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description
{
    NSArray *arr = @[@"access_token", @"expireDate", @"remind_in", @"uid", @"screen_name", @"avatar_large"];
    return [[self dictionaryWithValuesForKeys:arr] description];
    
}

#pragma mark NSCoding 协议方法
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.access_token forKey:@"access_token"];
    [coder encodeObject:self.expireDate forKey:@"expireDate"];
    [coder encodeObject:self.uid forKey:@"uid"];
    [coder encodeObject:self.screen_name forKey: @"screen_name"];
    [coder encodeObject:self.avatar_large forKey: @"avatar_large"];
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
