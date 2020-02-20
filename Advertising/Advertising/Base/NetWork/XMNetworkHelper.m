//
//  RKNetworkHelper.m
//  Refactoring
//
//  Created by 111 on 2019/6/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMNetworkHelper.h"
#import <AFNetworking.h>

@interface XMNetworkHelper ()

///请求头参数
@property (nonatomic, strong) NSMutableDictionary *headerParams;

@end

@implementation XMNetworkHelper

+ (instancetype)sharedNetworkHelper
{
    static XMNetworkHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[self alloc] init];
    });
    return helper;
}


/**
 GET请求接口
 @param url 请求接口
 @param parameters 接口传入参数内容
 @param progress 网络请求进度
 @param success 成功Block回调
 @param failure 失败Block回调
 */
- (void)GETUrl:(NSString *)url
    parameters:(id)parameters
      progress:(void(^)(NSProgress *downloadProgress))progress
       success:(void(^)(id responseObject))success
       failure:(void(^)(NSError *error))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:30.0f];
    [self.headerParams setObject:kLoginManager.userToken.length > 0 ? kLoginManager.userToken : @"" forKey:@"x-client-token"];
    for (NSString *params in self.headerParams) {
        [request setValue:self.headerParams[params] forHTTPHeaderField:params];
    }
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
                if (success) {
                    success(data);
                }
            } else {
                if (failure) {
                    failure(error);
                }
            }
        });
    }];
    [dataTask resume];
}

/**
 @param url 请求接口
 @param parameters 接口传入参数内容
 @param progress 网络请求进度
 @param success 成功Block回调
 @param failure 失败Block回调
 */
- (void)POSTUrl:(NSString *)url
     parameters:(id)parameters
       progress:(void(^)(NSProgress *downloadProgress))progress
        success:(void(^)(id responseObject))success
        failure:(void(^)(NSError *error))failure
{
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    req.HTTPMethod = @"POST";
    [req setTimeoutInterval:30.0f];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.headerParams setObject:kLoginManager.userToken.length > 0 ? kLoginManager.userToken : @"" forKey:@"x-client-token"];
    for (NSString *params in self.headerParams) {
        [req setValue:self.headerParams[params] forHTTPHeaderField:params];
    }
    req.HTTPBody = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
                if (success) {
                    success(data);
                }
            } else {
                if (failure) {
                    failure(error);
                }
            }
        });
    }];
    [dataTask resume];
}

#pragma mark - 请求头
- (NSMutableDictionary *)headerParams
{
    if (!_headerParams) {
        self.headerParams = [NSMutableDictionary dictionary];
        [self.headerParams setObject:kUserAgent.userAgent.length > 0 ? kUserAgent.userAgent : @"" forKey:@"User-Agent"];
        [self.headerParams setObject:@"" forKey:@"Cookie"];
        [self.headerParams setObject:@"application/json" forKey:@"Content-Type"];
    }
    return _headerParams;
}

@end
