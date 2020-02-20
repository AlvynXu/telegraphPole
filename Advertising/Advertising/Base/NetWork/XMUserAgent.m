//
//  RKUserAgent.m
//  Refactoring
//
//  Created by dingqiankun on 2019/5/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMUserAgent.h"

@implementation XMUserAgent

+ (instancetype)sharedInstance
{
    static XMUserAgent *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XMUserAgent alloc]init];

    });
    return sharedInstance;
}

- (NSString *)userAgent
{
    
    if (!_userAgent) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSString *basicAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        NSMutableString *userAgent =  [NSMutableString stringWithFormat:@"rongshu/ios/"];
        [userAgent appendString:kApp_Version];
        [userAgent appendFormat:@"/%@", basicAgent];
        _userAgent = [userAgent copy];
    }
   
    return _userAgent;
}

@end
