//
//  User.m
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)userWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

- (NSString *)description
{
    NSArray *arr = @[@"ID", @"screen_name", @"profile_image_url", @"verified_type", @"mbrank"];
    return [self dictionaryWithValuesForKeys:arr].description;
}


@end
