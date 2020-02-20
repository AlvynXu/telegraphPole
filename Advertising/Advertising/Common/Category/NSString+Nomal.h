//
//  NSString+Nomal.h
//  CXDToolKit
//
//  Created by 陈小东 on 15/3/4.
//  Copyright (c) 2015年 ___cxd___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Nomal)
- (BOOL)isEmpty;
- (BOOL)containsString:(NSString *)aString;


- (NSString *)encryptDESWithKey:(NSString *)key;
- (NSString *)decryptDESWithKey:(NSString *)key;
- (NSData *)encryptDESWithKeyResultData:(NSString *)key;
- (NSData *)decryptDESWithKeyResultData:(NSString *)key;
- (NSString *)stringByURLEncoding;
+ (NSString *)randomStringLength:(int)length;
//四舍保留2位小数
+ (NSString *)roundDownTwoecimalPlaces:(double)price;
+ (BOOL)isEmpty:(NSString *)text;
@end

@interface NSString (Check)
- (BOOL) validateEmail;
- (BOOL) validateMobile;
- (BOOL) validateqq;
- (BOOL) validateqqEmail;
- (BOOL) validateCode;
- (BOOL) validateRealName;
- (BOOL) validateNickName;
- (BOOL) validateUserId;
- (BOOL)isMatchRegex:(NSString *)regex;
- (BOOL)isContainerSpecial;
- (BOOL)isContainChinese;
- (BOOL)isContrainsEmoji;
@end

@interface NSString (UUID)
+ (NSString *)UUID;
@end

@interface NSString (Path)
+ (NSString *)cachesPath;
+ (NSString *)documentsPath;
+ (NSString *)temporaryPath;
+ (NSString *)pathForTemporaryFile;
@end

@interface NSString (Hash)
- (NSString *)MD5_16;
- (NSString *)MD5_32;
/**
 * @brief 使用SHA1算法进行签名
 *
 * @return 签名后字符串
 */
- (NSString *)sha1String;

/**
 *	@brief	使用HMac-SHA1进行签名
 *
 *	@param 	key 	密钥
 *
 *	@return	签名后字符串
 */
- (NSString *)hmacsha1StringWithKey:(NSString *)key;

/**
 *	@brief	使用HMac-SHA1进行签名
 *
 *	@param 	key 	密钥
 *
 *	@return	签名后的数据
 */
- (NSData *)dataUsinghmacsha1StringWithKey:(NSString *)key;


/**
 *	全部进行url编码 !*'();:@&=+$,%#[]
 *	@param encodeing 编码格式 kCFStringEncodingUTF8
 *	@return 编码后的字符串
 */
- (NSString *)urlEncodeAllRecode:(CFStringEncoding)encodeing;

/**
 * @brief url编码,使用utf8编码
 *
 * @return 编码后的字符串
 */
- (NSString *)urlEncodeUTF8;
/**
 * @brief url解码,使用utf8解码
 *
 * @return 解码后的字符串
 */
- (NSString *)urlDecodeUTF8;

/**
 * @brief  URL字符串编码
 *
 * @param encodeing 编码格式
 *
 * @return 编码后的字符串
 */
- (NSString *)urlEncode:(CFStringEncoding)encodeing;

/**
 * @brief URL字符串解码
 *
 * @param decodeing 编码格式
 *
 * @return 解码后的字符串
 */
- (NSString *)urlDecode:(NSStringEncoding)decodeing;

/**
 *	字符串转为16进制字符串
 *	@return 转换后得字符串
 */
- (NSString *)hexEncode;

/**
 *	从16进制字符串转为原字符串
 *	@return 转换后得字符串
 */
- (NSString *)hexDecode;


/**
 * @brief 字符串base64编码
 *
 * @param encoding 需要编码的字符串格式以及返回字符串的格式(UTF-8,GB2313...)
 *
 * @return 编码后的字符串
 */
- (NSString *)base64EncodedStringEncoding:(NSStringEncoding)encoding;

/**
 * @brief 字符串base64解码
 *
 * @param encoding 解码的字符串格式以及返回字符串的格式(UTF-8.GB2313...)
 *
 * @return 解码后的字符串
 */
- (NSString *)base64DecodedStringEncoding:(NSStringEncoding)encoding;

/**
 * @brief 字符串base64编码，默认编码格式时候UTF8
 *
 * @return 编码后的字符串
 */
- (NSString *)base64Encoded;

/**
 * @brief 字符串base64解码，默认编码格式时候UTF8
 *
 * @return 解码后的字符串
 */
- (NSString *)base64Decoded;

/**
 * @brief 字符串base64编码,utf8
 *
 * @return 编码后的数据data
 */
- (NSData *)base64DataFromString;

/**
 * @brief 字符串base64解码，使用UTF8
 *
 * @return 返回解码后的数据data
 */
- (NSData *)dataFromBase64String;

/**
 *	@brief	取得汉字的拼音首字母
 *
 *	@return	拼音首字母字符串(大写)
 */
- (NSString *)pinyinFirstLetter;

/**
 *	@brief	汉字转拼音字符串,带声调
 *
 *	@return	拼音字符串(小写)
 */
- (NSString *)pinyinString;

/**
 * @brief	汉字转拼音字符串没有声调
 *
 * @return 拼音字符串
 */
- (NSString *)pinyinNoTone;

/**
 * @brief	汉字转拼音字符串没有声调和空格
 *
 * @return 拼音字符串
 */
- (NSString *)pinyinNoToneAndSpace;

/**
 * @brief 字符串AES128位加密
 *
 * @param key 加密需要的key值,长度最少是16bit，可以进行md5、hash之后当key值
 *
 * @param encoding 加密需要转换的编码格式
 *
 * @return 加密后base64编码之后的字符串
 */
- (NSString *)stringUsingAES128EncryptWithkey:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_;

/**
 * @brief 字符串AES128位解密
 *
 * @param key 加密需要的key值,长度最少是16bit，可以进行md5、hash之后当key值
 *
 * @param encoding 解密需要转换的编码格式
 *
 * @return 解密后base64解码之后的字符串
 */
- (NSString *)stringUsingAES128DencryptWithkey:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_;


/**
 * @brief 字符串DES加密
 *
 * @param key 加密时需要的key值...
 *
 * @return 加密后的字符串
 */
- (NSString *)stringUsingDESEncryWithkey:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_;

/**
 * @brief 字符串DES解密
 *
 * @param key 解密时需要的key值...
 *
 * @return 解密后的字符串
 */
- (NSString *)stringUsingDESDencryWithkey:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_;

/**
 * @brief json字符串转换成字符串,使用UTF8编码
 *
 * @return 数组或者字典对象
 */
- (id)objectFromJSONString NS_AVAILABLE(10_7, 5_0);

/**
 *	AES128与base64加密
 */
- (NSString *)aes128WithBase64Etencrypt:(NSString *)key;

/**
 *	AES128与base64解密
 */
- (NSString *)aes128WithBase64Decrypt:(NSString *)key;

/**
 *    是否支持指纹
 */
+ (BOOL)iSSupportTouchID;
@end
