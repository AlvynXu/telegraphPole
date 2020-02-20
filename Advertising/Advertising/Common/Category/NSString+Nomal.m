//
//  NSString+Nomal.m
//  CXDToolKit
//
//  Created by 陈小东 on 15/3/4.
//  Copyright (c) 2015年 ___cxd___. All rights reserved.
//

#import "NSString+Nomal.h"
#import "NSData+Nomal.h"
#import "NSData+Encrypt.h"
#import "NSNumber+FlickerNumber.h"
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
//#import "UtilsMacro.h"

@implementation NSString (Nomal)
- (BOOL)isEmpty{
    if (self) {
        if ([[self class] isSubclassOfClass:[NSNull class]]) {
            return YES;
        }else if (self.length > 0) {
            if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
                return YES;
            }
            return NO;
        }else if(self == nil){
            return YES;
        }else if([self isEqualToString:@"(null)"]){
            return YES;
        }else{
            return YES;
        }
        
    }
    return YES;
}
+ (BOOL)isEmpty:(NSString *)text{
    if (text == nil){
        return YES;
    }else{
        return [text isEmpty];
    }
}

- (BOOL)containsString:(NSString *)aString{
    return [self rangeOfString:aString].location != NSNotFound;
}

- (NSString *) encryptDESWithKey:(NSString *)key{
    return[[self doCipher:self key:key context:kCCEncrypt] base64DecodedStringEncoding:NSUTF8StringEncoding];
}

- (NSString *) decryptDESWithKey:(NSString *)key{
    return[[self doCipher:self key:key context:kCCDecrypt] base64DecodedStringEncoding:NSUTF8StringEncoding];
}

- (NSData *)doCipher:(NSString *)sTextIn key:(NSString *)sKey
             context:(CCOperation)encryptOrDecrypt {
    NSData * data =[sTextIn dataUsingEncoding:NSUTF8StringEncoding];
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [sKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer
                                    length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *) encryptDESWithKeyResultData:(NSString *)key{
    return[self doCipher:self key:key context:kCCEncrypt];
}

- (NSData *) decryptDESWithKeyResultData:(NSString *)key{
    return[self doCipher:self key:key context:kCCDecrypt];
}

- (NSString *)stringByURLEncoding{
    CFStringRef escapedRef = CFURLCreateStringByAddingPercentEscapes(
                                                                     kCFAllocatorDefault,
                                                                     (__bridge CFStringRef) self,
                                                                     NULL,
                                                                     (__bridge CFStringRef) @"!*'\"();:@&=+$,/?%#[]% ~",
                                                                     kCFStringEncodingUTF8);
    
    return (NSString *) CFBridgingRelease(escapedRef);
}

+ (NSString *)randomStringLength:(int)length{
    char data[length];
    for (int x=0;x<length;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
}

+ (NSString *)roundDownTwoecimalPlaces:(double)price {
    NSString *value =[[NSNumber numberWithDouble:price] formatNumberDecimal];
    if (value) {
        if ([value containsString:@"."]) {
            NSArray *arr1 = [value componentsSeparatedByString:@"."];
            NSString * strPic = [arr1 objectAtIndex:1];
            NSString * strFirst = [arr1 objectAtIndex:0];
            if (!strFirst.length) {
                value = kFormat(@"0%@", value);
            }
            if (strPic.length < 2) {
                return kFormat(@"%@0", value);
            } else {
                return value;
            }
        } else {
            return kFormat(@"%@.00", value);
        }
    } else {
        return @"0.00";
    }
    /*
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSString *doubleStr = [NSString stringWithFormat:@"%@",roundedOunces];
    if ([doubleStr containsString:@"."]) {
        NSArray *array = [doubleStr componentsSeparatedByString:@"."];
        NSString *lastStr = array[1];
        if (lastStr.length && lastStr.length == 1) {//0.5
            lastStr  = [lastStr stringByAppendingFormat:@"0"];
            doubleStr = [array[0] stringByAppendingFormat:@".%@",lastStr];
        }
    } else {//3
        doubleStr  = [doubleStr stringByAppendingFormat:@".00"];
    }
    return doubleStr;
     */
}

@end

@implementation NSString (Check)
- (BOOL)validateEmail{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)validateMobile{
    NSString *phoneRegex = @"^1(3[0-9]|4[56789]|5[0-9]|6[6]|7[0-9]|8[0-9]|9[189])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return  [phoneTest evaluateWithObject:self];
}

- (BOOL)isMatchRegex:(NSString *)regex{
    return  [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:self];
}
- (BOOL)validateUserId{
    NSString *userIdRegex = @"^[0-9]+$";
    NSPredicate *userIdPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userIdRegex];
    BOOL B = [userIdPredicate evaluateWithObject:self];
    if (![self hasPrefix:@"1"] && B){
        return NO;
    }
    return B;
}

// 检查是否包含特殊字符
- (BOOL)isContainerSpecial
{
    if ([self isContainChinese] || [self isContrainsEmoji]) {
        return YES;
    }else{
        return NO;
    }
}

// 检验是否有中文
-(BOOL)isContainChinese
{
    BOOL exist = false;
    for(int i = 0;i < [self length];i++){
        int a = [self characterAtIndex:i];
        if(a > 0x4e00 &&a < 0x9fff){
            exist = true;
        }
    }
    return exist;
}

// 检验是否包含表情符号
- (BOOL)isContrainsEmoji {
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}


- (BOOL)validateqq{
    NSString *qqRegex = @"^[0-9]+$";
    NSPredicate *qqTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqRegex];
    return [qqTest evaluateWithObject:self];
}

- (BOOL)validateqqEmail{
    //@"^[0-9]{4,12}@(qq|QQ).com"
    NSString *qqEmailRegex = @"^[0-9]{4,13}";
    NSPredicate *qqEmailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqEmailRegex];
    return [qqEmailTest evaluateWithObject:self];
}

- (BOOL)validateCode{
    NSString *codeRegex = @"^[0-9]{6}";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    return [codeTest evaluateWithObject:self];
}

- (BOOL)validateRealName{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}

- (BOOL)validateNickName{
    NSString *userNameRegex = @"^[A-Za-z0-9\u4e00-\u9fa5]{1,24}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}
@end


@implementation NSString (UUID)
+ (NSString *)UUID{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    return uuidString;
}
@end

@implementation NSString (Path)
+ (NSString *)cachesPath{
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    });
    
    return cachedPath;
}

+ (NSString *)documentsPath{
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    });
    
    return cachedPath;
}

#pragma mark Temporary Paths

+ (NSString *)temporaryPath{
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = NSTemporaryDirectory();
    });
    
    return cachedPath;
}

+ (NSString *)pathForTemporaryFile{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    NSString *tmpPath = [[NSString temporaryPath] stringByAppendingPathComponent:(__bridge NSString *)newUniqueIdString];
    CFRelease(newUniqueId);
    CFRelease(newUniqueIdString);
    
    return tmpPath;
}
@end

@implementation NSString (Hash)
- (NSString *)MD5_16{
    if (self==nil){
        return nil;
    }
    return [[self MD5_32] substringWithRange:NSMakeRange(8, 16)];
}

- (NSString *)MD5_32{
    if (self==nil){
        return nil;
    }
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 * @brief 使用SHA1算法进行签名
 *
 * @return 签名后字符串
 */
- (NSString *)sha1String
{
    if (self==nil){
        return self;
    }
    const char *cStr = [self UTF8String];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

/**
 *	@brief	使用HMac-SHA1进行签名
 *
 *	@param 	key 	密钥
 *
 *	@return	签名后字符串
 */
- (NSString *)hmacsha1StringWithKey:(NSString *)key
{
    if (self==nil){
        return nil;
    }
    const char * ckey=[key UTF8String];
    const char * cdata=[self UTF8String];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, ckey, strlen(ckey), cdata, strlen(cdata), cHMAC);
    
    __autoreleasing NSString * string=[[NSString alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH encoding:NSUTF8StringEncoding];
    return string;
}


/**
 *	@brief	使用HMac-SHA1进行签名
 *
 *	@param 	key 	密钥
 *
 *	@return	签名后的数据
 */
- (NSData *)dataUsinghmacsha1StringWithKey:(NSString *)key
{
    if (self==nil){
        return nil;
    }
    const char * ckey=[key UTF8String];
    const char * cdata=[self UTF8String];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, ckey, strlen(ckey), cdata, strlen(cdata), cHMAC);
    NSData * data=[NSData dataWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    return data;
}


- (NSString *)urlEncodeAllRecode:(CFStringEncoding)encodeing
{
    
    //kCFStringEncodingUTF8
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,%#[]",
                                                              encodeing));
    return outputStr;
    
}

/**
 * @brief  URL字符串编码
 *
 * @param encodeing 编码格式
 *
 * @return 编码后的字符串
 */
- (NSString *)urlEncode:(CFStringEncoding)encodeing
{
    return [self stringByAddingPercentEscapesUsingEncoding:encodeing];
    /*
     //kCFStringEncodingUTF8
     // Encode all the reserved characters, per RFC 3986
     // (<http://www.ietf.org/rfc/rfc3986.txt>)
     NSString *outputStr = (NSString *)
     CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
     (CFStringRef)self,
     NULL,
     (CFStringRef)@"!*'();:@&=+$,%#[]",
     encodeing);
     return [outputStr autorelease];
     */
}



- (NSString *)urlEncodeUTF8
{
    return [self urlEncode:NSUTF8StringEncoding];
}

- (NSString *)urlDecodeUTF8
{
    return [self urlDecode:NSUTF8StringEncoding];
}
/**
 * @brief URL字符串解码
 *
 * @param decodeing 编码格式
 *
 * @return 解码后的字符串
 */
- (NSString *)urlDecode:(NSStringEncoding)decodeing
{
    if (self==nil){
        return nil;
    }
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:decodeing];
}


- (NSString *)hexEncode
{
    if (!self){
        return nil;
    }
    NSData * data=[self dataUsingEncoding:NSUTF8StringEncoding];
    NSData * eData=[data hexEncode];
    
    __autoreleasing NSString *result=[[NSString alloc] initWithData:eData encoding:NSUTF8StringEncoding];
    return result;
    
}

- (NSString *)hexDecode
{
    if (!self){
        return nil;
    }
    NSData * data=[self dataUsingEncoding:NSUTF8StringEncoding];
    NSData * eData=[data hexDecode];
    
    __autoreleasing NSString *result=[[NSString alloc] initWithData:eData encoding:NSUTF8StringEncoding];
    return result;
}

/**
 * @brief 字符串base64编码
 *
 * @param encoding 需要编码的字符串格式以及返回字符串的格式(UTF-8,GB2313...)
 *
 * @return 编码后的字符串
 */
- (NSString *)base64EncodedStringEncoding:(NSStringEncoding)encoding
{
    if (self==nil ){
        return nil;
    }
    NSData * data=[self dataUsingEncoding:encoding];
    return [data base64EncodedStringEncoding:encoding];
}

/**
 * @brief 字符串base64解码
 *
 * @param encoding 解码的字符串格式以及返回字符串的格式(UTF-8.GB2313...)
 *
 * @return 解码后的字符串
 */
- (NSString *)base64DecodedStringEncoding:(NSStringEncoding)encoding
{
    if (self==nil){
        return nil;
    }
    NSData * data=[NSData dataFromBase64String:self encoding:encoding];
    __autoreleasing NSString * result=[[NSString alloc] initWithData:data encoding:encoding];
    return result;
}

/**
 * @brief 字符串base64编码，默认编码格式时候UTF8
 *
 * @return 编码后的字符串
 */
- (NSString *)base64Encoded
{
    return [self base64EncodedStringEncoding:NSUTF8StringEncoding];
}

/**
 * @brief 字符串base64解码，默认编码格式时候UTF8
 *
 * @return 解码后的字符串
 */
- (NSString *)base64Decoded
{
    return [self base64DecodedStringEncoding:NSUTF8StringEncoding];
}

/**
 * @brief 字符串base64编码,utf8
 *
 * @return 编码后的数据data
 */
- (NSData *)base64DataFromString
{
    NSData * data=[self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64Encodeds];
}

/**
 * @brief 字符串解码，使用UTF8
 *
 * @return 返回解码后的数据data
 */
- (NSData *)dataFromBase64String
{
    if (self==nil){
        return nil;
    }
    return [NSData dataFromBase64String:self encoding:NSUTF8StringEncoding];
}

/**
 *	@brief	汉字转拼音字符串
 *
 *	@return	拼音字符串(小写)
 */
- (NSString *)pinyinString
{
    if (self==nil){
        return nil;
    }
    
    CFMutableStringRef string =CFStringCreateMutableCopy(NULL, 0, (CFStringRef)self);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    // CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    
    CFAutorelease(string);
    
    return (__bridge NSString *)string;
}


- (NSString *)pinyinNoTone
{
    if (self==nil){
        return nil;
    }
    
    CFMutableStringRef string =CFStringCreateMutableCopy(NULL, 0, (CFStringRef)self);
    ///转换成拼音
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    ///去掉声调
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    CFAutorelease(string);    //
    
    return (__bridge NSString *)string;
}

- (NSString *)pinyinNoToneAndSpace
{
    if (self==nil){
        return nil;
    }
    NSString * string=[self pinyinNoTone];
    string=[string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}


/**
 *	@brief	取得汉字的拼音首字母
 *
 *	@return	拼音首字母字符串(大写)
 */
- (NSString *)pinyinFirstLetter
{
    if (self==nil){
        return nil;
    }
    NSMutableString * string=[NSMutableString string];
    
    @try{
        NSString *noToneString=[self pinyinNoTone];
        NSArray *spaceList=[noToneString componentsSeparatedByString:@" "];
        for (int i=0; i<[spaceList count]; i++){
            [string appendFormat:@"%c",[spaceList[i] UTF8String][0]];
        }
        
        /*
         for (int i=0; i<[self length]; i++){
         [string appendFormat:@"%c",ESPinyinFirstLetter([string characterAtIndex:i])];
         }*/
        
    }
    @catch (NSException *exception){
        
    }
    @finally{
        
    }
    
    
    return [string uppercaseString];
}


- (NSString *)stringUsingAES128EncryptWithkey:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_
{
    
    NSData * data=[self dataUsingEncoding:encoding];
    
    NSData * enData=[data dataUsingAES128EncryptWithkey:[key dataUsingEncoding:encoding] withIV:iv_];
    
    return [enData base64EncodedStringEncoding:encoding];
    
}
- (NSString *)stringUsingAES128DencryptWithkey:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_
{
    
    NSData * data=[NSData dataFromBase64String:self encoding:encoding];
    
    NSData * deData=[data dataUsingAES128DecryptWithkey:[key dataUsingEncoding:encoding] withIV:iv_];
    __autoreleasing NSString * result=[[NSString alloc] initWithData:deData encoding:encoding];
    return  result;
}


- (NSString *)stringUsingDESEncryWithkey:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_
{
    
    NSData * data=[self dataUsingEncoding:encoding];
    
    NSData * enData=[data dataUsingDESEncryWithkey:[key dataUsingEncoding:encoding] withIV:iv_];
    
    return [enData base64EncodedStringEncoding:encoding];
}

- (NSString *)stringUsingDESDencryWithkey:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_
{
    NSData * data=[NSData dataFromBase64String:self encoding:encoding];
    NSData * deData=[data dataUsingDESDencryWithkey:[key dataUsingEncoding:encoding] withIV:iv_];
    __autoreleasing NSString * result=[[NSString alloc] initWithData:deData encoding:NSUTF8StringEncoding];
    return result;
}

/**
 * @brief json字符串转换成字符串,使用UTF8编码
 *
 * @return 数组或者字典对象
 */
- (id)objectFromJSONString
{
    NSData * data=[self dataUsingEncoding:NSUTF8StringEncoding];
    return [data objectFromJSONData];
}

- (NSString *)aes128WithBase64Etencrypt:(NSString *)key {
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    //对数据进行AES加密
    NSData *result = [data aes128EncryptWithKey:key];
    NSString *strEncod = [result base64EncodedStringEncoding:NSUTF8StringEncoding];
    return strEncod;
}

- (NSString *)aes128WithBase64Decrypt:(NSString *)key {
    NSString *steDncod =  [self base64Decoded];
    const char *cstr = [steDncod cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    NSString *result = [[NSString alloc] initWithData:[data aes128DecryptWithKey:key] encoding:NSUTF8StringEncoding];
    return result;
}

+ (BOOL)iSSupportTouchID {
    if(!IS_IPAD) {
        if([self platform].length > 7 ) {
            if (kIphoneX) {
                return NO;
            }
            NSString * numberPlatformStr = [[self platform] substringWithRange:NSMakeRange(6, 2)];
            NSInteger numberPlatform = [numberPlatformStr integerValue];
            if(numberPlatform > 5) {// 是否是5s以上的设备
                return YES;
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    } else { // 不支持iPad设备
        return NO;
    }
}

+ (NSString *)platform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

@end
