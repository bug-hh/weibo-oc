//
//  NetworkTools.m
//  weibo-oc
//
//  Created by 彭豪辉 on 2020/7/4.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "NetworkTools.h"

typedef enum NSUInteger {
    GET,
    POST
} HHRequestMethod;

@protocol NetworkToolsProxy <NSObject>

// 这个方法是父类（即 AFN 框架内部的一个私有方法，get，post 请求最终都会调用它
@optional
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
       URLString:(NSString *)URLString
      parameters:(nullable id)parameters
         headers:(nullable NSDictionary <NSString *, NSString *> *)headers
  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
         success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
         failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

@end

// 遵守网络协议，为了欺骗 xcode，给一个智能提示，以及编译通过
@interface NetworkTools() <NetworkToolsProxy>

@property(copy, nonatomic) NSString *appKey;
@property(copy, nonatomic) NSString *appSecret;
@property(copy, nonatomic) NSString *redirectUrl;
@property(copy, nonatomic) NSString *oauthURL;

@end

@implementation NetworkTools

- (NSString *)appKey {
    return @"3305836468";
}

- (NSString *)appSecret {
    return @"e75ef60521e249f5dd2882d288c98907";
}

- (NSString *)redirectUrl {
    return @"https://bug-hh.github.io/bughh.github.io/";
}

- (NSString *)oauthURL {
    if (!_oauthURL) {
        _oauthURL = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", self.appKey, self.appSecret];
    }
    return _oauthURL;
}

+ (instancetype)sharedTools {
    static NetworkTools *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:nil];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",
        @"text/javascript", @"text/html", nil];
    });
    
    return instance;
}

# pragma mark - OAuth 相关方法
- (void)accessTokenWithCode:(NSString*)code andFinish:(^()())

# pragma mark - 封装 AFN 网络方法
- (void)request:(HHRequestMethod)httpMethod andUrl:(NSString *)url andParameters:(NSDictionary *)dict andFinish:(finish)finished {
    NSString *method = httpMethod == GET ? @"GET" : @"POST";
    // 虽然 NetworkTools 本身没有实现这个方法，但是它的父类实现了，那么就正好调用了父类（AFN 框架）的实现
    [[self dataTaskWithHTTPMethod:method URLString:url parameters:dict headers:nil uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        finished(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        finished(nil, error);
    }] resume];
}

@end