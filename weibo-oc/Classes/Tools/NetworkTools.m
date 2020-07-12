//
//  NetworkTools.m
//  weibo-oc
//
//  Created by 彭豪辉 on 2020/7/4.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "NetworkTools.h"
#import "UserAccountViewModel.h"

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
@property(copy, nonatomic) NSDictionary *tokenDict;

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
        _oauthURL = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", self.appKey, self.redirectUrl];
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

- (NSDictionary *)tokenDict {
    NSString *access_token = UserAccountViewModel.sharedViewModel.accessToken;
    return access_token ? @{@"access_token": access_token} : nil;
}

#pragma mark 获取用户微博数据
/**
     加载微博数据
   * parameter since_id   若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
   * parameter max_id   若指定此参数，则返回ID小于或等于max_id的微博，默认为0
   * parameter finish  回调函数
*/
- (void)loadStatusWithSinceId:(NSNumber*)sinceId andMaxId:(NSNumber*)maxId finishCallback:(finish)finished {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    // 判断是否为下拉刷新
    if (sinceId > 0) {
        parameters[@"since_id"] = @(sinceId.longValue);
    } else if (maxId > 0) {
        // 加@()  变成 NSNumber 类型
        parameters[@"max_id"] = @(maxId.longValue - 1);
    }
    NSString *url = @"https://api.weibo.com/2/statuses/home_timeline.json";
    [self tokenRequest:GET andUrl:url andParameters:parameters andFinish:finished];
}

#pragma mark 获取用户信息
- (void)loadUserInfoWithUid:(NSString*)uid finish:(finish)finished {
    if (!self.tokenDict) {
        finished(nil, [NSError errorWithDomain:@"com.bughh.weibo" code:-1001 userInfo:@{@"message": @"access token 为空"}]);
        return;
    }
    
    // 创建参数字典
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:self.tokenDict];
    parameters[@"uid"] = uid;
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    [self request:GET andUrl:url andParameters:parameters andFinish:finished];
}

# pragma mark - OAuth 相关方法
- (void)accessTokenWithCode:(NSString*)code andFinish:(finish)finished {
    NSString *url = @"https://api.weibo.com/oauth2/access_token";
    NSDictionary *parameters = @{
        @"client_id": @"3305836468",
        @"client_secret": @"e75ef60521e249f5dd2882d288c98907",
        @"grant_type": @"authorization_code",
        @"code": code,
        @"redirect_uri": @"https://bug-hh.github.io/bughh.github.io/"
    };
    
    [self request:POST andUrl:url andParameters:parameters andFinish:finished];
}



# pragma mark - 封装 AFN 网络方法
- (BOOL)appendToken:(NSMutableDictionary*)parameters {
    NSString *token = UserAccountViewModel.sharedViewModel.accessToken;
    
    if (!token) {
        return NO;
    }
    
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }
    [parameters setValue:token forKey:@"access_token"];
    return YES;
}

- (void)tokenRequest:(HHRequestMethod)httpMethod andUrl:(NSString *)url andParameters:(NSMutableDictionary *)parameters andFinish:(finish)finished {
    if (![self appendToken:parameters]) {
        finished(nil, [NSError errorWithDomain:@"com.bughh.error" code:1000 userInfo:@{@"message": @"无效 token"}]);
        return;
    }
    [self request:httpMethod andUrl:url andParameters:parameters andFinish:finished];
}

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
