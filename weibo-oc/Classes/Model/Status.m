//
//  Status.m
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "Status.h"

@implementation Status

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)statusWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"user"]) {
        self.user = [User userWithDict:value];
        return;
    }
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

- (NSString *)description
{
    NSArray *arr = @[@"ID", @"text", @"create_at", @"source", @"user"];
    return [self dictionaryWithValuesForKeys:arr].description;
}

@end
