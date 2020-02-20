//
//  RKJsonHelper.m
//  Refactoring
//
//  Created by 111 on 2019/6/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMJsonHelper.h"

@implementation XMJsonHelper

+ (instancetype)sharedInstance
{
    static XMJsonHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/**
 *NSData转字典
 */
- (NSDictionary *)getJsonDict:(NSData *)data
{
    if (data == nil || [data isKindOfClass:[NSNull class]]) {
        return @{};
    }
    @try {
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        return resultDic;
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    } @finally {
        
    }
}

/**
 *NSData转数组
 */
- (NSMutableArray *)getJsonArray:(NSData *)data
{
    if (data == nil) {
        return [NSMutableArray array];
    }
    @try {
        NSMutableArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        return resultArray;
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

@end
