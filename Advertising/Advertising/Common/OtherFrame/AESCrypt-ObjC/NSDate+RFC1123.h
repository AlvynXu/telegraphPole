//
//  NSDate+RFC1123.h
//  TopBroker4
//
//  Created by 杨红丽 on 16/4/20.
//  Copyright © 2016年 kakao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RFC1123)

+(NSDate *)dateFromRFC1123:(NSString*)value_;

-(NSString *)rfc1123String;

- (NSDate *)destinationDateNow;

+(NSString *)getCurrentTimestamp;


@end
