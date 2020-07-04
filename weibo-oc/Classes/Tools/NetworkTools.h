//
//  NetworkTools.h
//  weibo-oc
//
//  Created by 彭豪辉 on 2020/7/4.
//  Copyright © 2020 bughh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^finish)(id __nullable response, NSError * _Nullable error);

@interface NetworkTools : AFHTTPSessionManager

+ (instancetype)sharedTools;

@end

NS_ASSUME_NONNULL_END
