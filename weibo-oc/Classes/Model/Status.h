//
//  Status.h
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Status : NSObject

// 微博 id
@property(strong, nonatomic) NSNumber *ID;
// 微博内容
@property(copy, nonatomic) NSString *text;
// 微博创建时间
@property(copy, nonatomic) NSString *create_at;
// 微博来源
@property(copy, nonatomic) NSString *source;
// 用户模型
@property(strong, nonatomic) User *user;
// 图片数组
@property(strong, nonatomic) NSArray<NSDictionary*> *pic_urls;

- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)statusWithDict:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
