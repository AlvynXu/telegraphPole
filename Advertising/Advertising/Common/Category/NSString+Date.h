//
//  NSString+Date.h
//  Refactoring
//
//  Created by dingqiankun on 2019/5/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Date)

//日期格式化
+(NSDateFormatter *)dateFormatWith:(NSString *)formatStr;

//获取当前时间戳
+(NSString *)getNowTimestamp;

//将时间转换为时间戳
+ (NSString *)dateToTimestamp:(NSDate *)date;

//将时间转换为时间字符串
+ (NSString *)dateToTimeStr:(NSDate *)date;

//将时间戳转换为时间
+ (NSDate *)timestampToDate:(CGFloat)timestamp;

//将时间字符串转换为时间戳
+ (NSString *)timeStrToTimestamp:(NSString *)timeStr withTimeFomart:(NSString *)timeFormat;

//将时间字符串转换为时间
+ (NSDate *)timeStrToDate:(NSString *)timeStr withTimeFormat:(NSString *)timeFormat;

//将时间戳转换为时间字符串
+ (NSString *)timestampToTimeStr:(CGFloat)timestamp withFormat:(NSString *)timeFormat;

// 时间比较
+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02 withFormat:(NSString *)format;


@end

NS_ASSUME_NONNULL_END
