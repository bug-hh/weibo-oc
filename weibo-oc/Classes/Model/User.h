//
//  User.h
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property(strong, nonatomic) NSNumber *ID;
@property(copy, nonatomic) NSString *screen_name;
@property(copy, nonatomic) NSString *profile_image_url;
@property(strong, nonatomic) NSNumber *verified_type;
@property(strong, nonatomic) NSNumber *mbrank;

- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)userWithDict:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
