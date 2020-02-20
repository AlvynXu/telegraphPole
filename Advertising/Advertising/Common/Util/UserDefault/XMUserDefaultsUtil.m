//
//  RKUserDefaultsUtils.m
//  Refactoring
//
//  Created by dingqiankun on 2019/3/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMUserDefaultsUtil.h"
#import "NSData+CommonCrypto.h"

static const NSString *aes256key = @"com.rk.03080414.noencrypted";

@implementation XMUserDefaultsUtil

+ (void)xm_saveValue:(id)value forkey:(NSString *)key
{
    // 先加密 后存储
    NSData *encryptedData = [self AES256EncryptedDataUsingValue:value];
    [kUserDefaults setObject:encryptedData forKey:key];
    [kUserDefaults synchronize];
}

+ (id)xm_valueWithKey:(NSString *)key
{
    
//    BOOL isContainerKey = NO;
//    NSDictionary *dicts = [kUserDefaults dictionaryRepresentation];
//    for (NSString *keys in dicts) {
//        if ([keys isEqualToString:key]) {
//            isContainerKey = YES;
//            break;
//        }
//    }
//    NSLog(@"------------  %d", isContainerKey);
//    if (!isContainerKey) {
//        return @"";
//    }
//
//    return @"";
   
    NSString* value = [kUserDefaults objectForKey:key];
    // 解密
    if ([value isKindOfClass:[NSData class]] && value) {
        // 解密
        NSData *data = [self decryptedAES256DataUsingValue:value];
        NSDictionary *dict;
        @try {
            dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        } @catch (NSException *exception) {
            NSLog(@"解码异常exceptionName:%@,reason:%@",[exception name],[exception reason]);
            return data;
        } @finally {

        }
        return dict;
    }
    return value;
}

+ (void)xm_saveBoolValue:(BOOL)value withKey:(NSString *)key
{
    [kUserDefaults setBool:value forKey:key];
    [kUserDefaults synchronize];
}

+ (BOOL)xm_boolValueWithKey:(NSString *)key;
{
    return [kUserDefaults boolForKey:key];
}


// AES加密
+ (NSData *)AES256EncryptedDataUsingValue:(id)value
{
    NSData *data = nil;
    if ([value isKindOfClass:[NSData class]]) {
        data = [NSData dataWithData:data];
    } else {
        NSError *error;
        @try {
            data = [NSKeyedArchiver archivedDataWithRootObject:value requiringSecureCoding:YES error:&error];
        } @catch (NSException *exception) {
            NSLog(@"(((((((((((((   归档失败%@", error);
            return value;
        } @finally {
            
        }
    }
    NSError *error = nil;
    data = [data AES256EncryptedDataUsingKey:aes256key error:&error];
    if (error == nil) {
        return data;
    }
    return nil;
}


// AES解密
+ (NSData *)decryptedAES256DataUsingValue:(id)value
{
    NSData *data = [NSData dataWithData:value];
    NSError *error = nil;
    data = [data decryptedAES256DataUsingKey:aes256key error:&error];
    if (!data) {
        return nil;
    }
    return data;
}

@end
