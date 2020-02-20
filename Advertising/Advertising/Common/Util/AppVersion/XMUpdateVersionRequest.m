//
//  XMUpdateVersionRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMUpdateVersionRequest.h"

//

@implementation XMUpdateModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"desc":@"description"};
}


- (BOOL)hasUpdate{
    NSString *currentVersion =  kApp_Version?:kApp_BuildVersion;
    return [self versionCompare:currentVersion smallerThan:self.appVersion];
}

// 比较版本号
- (BOOL)versionCompare:(NSString *)currentVer smallerThan:(NSString *)compareVer{
    NSArray *currentIntArray = [currentVer componentsSeparatedByString:@"."];
    NSArray *compareIntArray = [compareVer componentsSeparatedByString:@"."];
    NSInteger count = MIN(currentIntArray.count, compareIntArray.count);
    for (int i=0; i<count; i++) {
        BOOL currentBigger = [currentIntArray[i] integerValue]>[compareIntArray[i] integerValue];
        BOOL currentSmaller = [currentIntArray[i] integerValue]<[compareIntArray[i] integerValue];
        if(currentBigger){
            return NO;
        }else if(currentSmaller){
            return YES;
        }
        if (i == (count-1) && currentIntArray.count>=compareIntArray.count) {
            return NO;
        }
    }
    return YES;
}

- (NSString *)updateInfo
{
    if (self.forceUpdate) {
        return [self.desc isEmpty]?@"当前版本太低，无法正常使用，请下载最新版本":self.desc;
    }else{
        return [self.desc isEmpty]?@"版本已更新，请下载最新版本体验":self.desc;
    }
    
}


@end


@implementation XMUpdateVersionRequest

- (NSString *)requestUrl
{
    return @"api/appVersion/getAppVersion";
}

- (id)requestArgument
{
    return @{@"type":@(1)};
}

- (Class)modelClass
{
    return XMUpdateModel.class;
}

@end
