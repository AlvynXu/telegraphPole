//
//  RKBaseRequest.m
//  Refactoring
//
//  Created by dingqiankun on 2019/3/22.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"

@interface XMBaseRequest()

@property(nonatomic, strong)NSError *businessError;


@end

@implementation XMBaseRequest

// 常量、根据个人公司接口的信息设置
NSString *const code_m = @"code";
NSString *const msg_m = @"message";
NSString *const data_m = @"data";
static int const loginOutTimeCode = 100;  // 登录超时

+ (instancetype)request
{
    return [[self alloc] init];
}

- (void)warning:(NSString *)selector
{
    NSString *warning = @"";
    if ([XMBaseRequest isKindOfClass:self.class]) {
        warning = @"该类请勿直接使用，请继承 [RKBaseRequest] 类";
    }else{
        warning = [NSString stringWithFormat:@"请在子类实现%@方法", selector];
    }
    NSAssert(NO, warning);
}

- (Class)modelClass
{
    [self warning:NSStringFromSelector(_cmd)];
    return nil;
}

// 默认GET请求
- (YTKRequestMethod)requestMethod{
    
    return YTKRequestMethodGET;
}

// 默认JSON 类型
- (YTKRequestSerializerType)requestSerializerType{
    
    return YTKRequestSerializerTypeJSON;
}

//- (id)responseObject
//{
//    if (self.responseData) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableContainers error:nil];
//        return dict;
//    }
//    return [super responseObject];
//
//}

// 覆盖父类的方法设置请求头文件
- (NSDictionary *)requestHeaderFieldValueDictionary {
    // 设置请求头
    NSMutableDictionary *headers =  @{
                                      @"token":kLoginManager.userToken ? kLoginManager.userToken : @"",
                                      @"User-Agent":@"",
                                      @"Cookie":@""
                                      }.mutableCopy;
    return headers;
}

- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}

// 业务判断是否成功
- (BOOL)businessSuccess
{
    if (self.responseObject && [self.responseObject isKindOfClass:[NSDictionary class]]) {
        if ([[self.responseObject allKeys] containsObject:code_m]) {
            return [self.responseObject[code_m] integerValue] == 0 || [self.responseObject[code_m] integerValue] == 200;
        }
    }
    return NO;
}

- (NSInteger)businessCode
{
    if (self.responseObject && [self.responseObject isKindOfClass:[NSDictionary class]]) {
        
        if ([[self.responseObject allKeys] containsObject:code_m]) {
            return [self.responseObject[code_m] integerValue];
        }
    }
    return -1;
}

// 业务错误
- (NSError *)businessError
{
    NSError *error = nil;
    if (self.responseObject && [self.responseObject isKindOfClass:[NSDictionary class]]) {
        if ([[self.responseObject allKeys] containsObject:code_m]) {
            if ([self.responseObject[code_m] integerValue] != 0) {
                error = [[NSError alloc] initWithDomain:NSXMLParserErrorDomain code:self.businessCode userInfo:@{NSLocalizedDescriptionKey:self.businessMessage}];
            }
        }
    }
    return error;
}

// 业务信息

- (NSString *)businessMessage
{
    NSString *msg = @"empty message";
    if (self.responseObject && [self.responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *resDict = self.responseObject;
        if ([resDict.allKeys containsObject:msg_m]) {
             msg = self.responseObject[msg_m];
            if ([msg isEqualToString:@"success"]) {
                msg = @"成功";
            }
        }
    }
    return msg;
}

- (id)businessData
{
    if (self.responseObject && [self.responseObject isKindOfClass:NSDictionary.class]) {
        if ([[self.responseObject allKeys] containsObject:data_m]) {
            id data = self.responseObject[data_m];
            return [data isKindOfClass:NSNull.class] ? nil : data;
        }
    }
    return nil;
}

- (id)businessModel
{
    if (!self.modelClass) {
        return nil;
    }
    if ([self.businessData isKindOfClass:NSDictionary.class]) {
       return [self.modelClass mj_objectWithKeyValues:self.businessData];
    }
    
    if ([self.businessData isKindOfClass:NSArray.class]) {
       return [self.modelClass mj_objectWithKeyValues:self.responseObject];
    }
    return nil;
}

// 重写错误方法
- (NSError *)error
{
    NSError *error = [super error];
    if (error.code && !self.responseObject) {
        if (error.code == -1004 || error.code == -1009) {
            error = [[NSError alloc] initWithDomain:NSXMLParserErrorDomain code:error.code userInfo:@{NSLocalizedDescriptionKey: @"当前网络不可用,请检查网络设置"}];
        }else{
            error = [[NSError alloc] initWithDomain:NSXMLParserErrorDomain code:error.code userInfo:@{NSLocalizedDescriptionKey: self.response.statusCode==401?@"登录失效，请重新登录":@"暂未收到您的请求，请刷新页面重试"}];
        }
        return error;
    }else{
        return self.businessError;
    }
    
}
// 请求以信号方式发送
+ (RACSignal *)requestSignal
{
    return [[[self alloc] init] requestSignal];
}

- (RACSignal *)requestSignal
{
    RACSignal *signal = [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self startWithCompletion:^(__kindof XMBaseRequest * _Nonnull request, NSError * _Nonnull error) {
            [subscriber sendNext:request];
            [subscriber sendCompleted];
        }];
        RACDisposable *disposable = [RACDisposable disposableWithBlock:^{
            
            if(self.isExecuting){
                
            }
            if (self) {
                [[YTKNetworkAgent sharedAgent] cancelRequest:self];
            }
        }];
        return disposable;
    }] publish] autoconnect] ;
    return signal;
}


- (void)startWithCompletion:(RequestCompleteBlock)completeBlock
{
    self.ignoreCache = NO;
    [self startWithCompletionBlockWithSuccess:^(__kindof XMBaseRequest * _Nonnull request) {
        if (completeBlock) {
            completeBlock(request, request.error);
        }
    } failure:^(__kindof XMBaseRequest * _Nonnull request) {
        if (completeBlock) {
            // 登录超时  服务器判断
            if (request.responseStatusCode == 401) {
                
                if (request.responseObject) {  // 判断服务器数据是否返回
                    if (request.businessCode == loginOutTimeCode) {
                        // 如果有返回 判断code是否等于100 如果是退出登录
                        [XMHUD showText:@"登录失效，请重新登录"];
                        [kLoginManager loginOut];
                        [kLoginManager goLoginComplete:^{
                            
                        } animation:YES];
                    }
                }else{
                    // 如果没有返回退出登录
                    [XMHUD showText:@"登录失效，请重新登录"];
                    [kLoginManager loginOut];
                    [kLoginManager goLoginComplete:^{
                        
                    } animation:YES];
                }
                
            }
            completeBlock(request, request.error);
        }
    }];
}


@end
