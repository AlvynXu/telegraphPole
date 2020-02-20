//
//  RKEncryptionUtil.m
//  Refactoring
//
//  Created by dingqiankun on 2019/3/25.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "RKEncryptionUtil.h"
#import <CommonCrypto/CommonDigest.h>

@implementation RKEncryptionUtil

+ (NSString *)md5String:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr,(unsigned int)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

@end
