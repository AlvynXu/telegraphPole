//
//  NSData+Encrypt.h
//  BiT
//
//  Created by LEI on 2018/3/28.
//  Copyright © 2018年 LEI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encrypt)

- (NSData *)aes128EncryptWithKey:(NSString *)key;   //加密

- (NSData *)aes128DecryptWithKey:(NSString *)key;   //解密

@end
