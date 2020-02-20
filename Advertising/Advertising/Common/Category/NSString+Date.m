//
//  NSString+Date.m
//  Refactoring
//
//  Created by dingqiankun on 2019/5/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

//将时间戳转换为时间字符串
+ (NSString *)timestampToTimeStr:(CGFloat)timestamp withFormat:(NSString *)timeFormat
{
    
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *timeStr=[[self dateFormatWith:timeFormat] stringFromDate:date];
    
    return timeStr;
}

//将时间戳转换为时间
+ (NSDate *)timestampToDate:(CGFloat)timestamp {
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timestamp];
    
    //解决8小时时差问题
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    
    
    return localeDate;
}


//将时间字符串转换为时间戳
+ (NSString *)timeStrToTimestamp:(NSString *)timeStr withTimeFomart:(NSString *)timeFormat
{
    
    NSDate *date = [self timeStrToDate:timeStr withTimeFormat:timeFormat];
    NSTimeInterval stamp = [date timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%.0f", stamp];
}

//将时间字符串转换为时间
+ (NSDate *)timeStrToDate:(NSString *)timeStr withTimeFormat:(NSString *)timeFormat
{
    
    NSDate *date = [[self dateFormatWith:timeFormat] dateFromString:timeStr];
    
    //解决8小时时差问题
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    
    return localeDate;
}

//获取当前时间戳
+(NSString *)getNowTimestamp {
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    return [self dateToTimestamp:date];
}

//将时间转换为时间戳
+ (NSString *)dateToTimestamp:(NSDate *)date {
    
    NSTimeInterval stamp = [date timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%.0f", stamp];
}

//将时间转换为时间字符串
+ (NSString *)dateToTimeStr:(NSDate *)date {
    
    NSString *timeStr = [[self dateFormatWith:@"YYYY-MM-dd HH:mm:ss"] stringFromDate:date];
    
    return timeStr;
}


//获取日期格式化器
+(NSDateFormatter *)dateFormatWith:(NSString *)formatStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatStr];//@"YYYY-MM-dd HH:mm:ss"
    //设置时区
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    return formatter;
}

+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02 withFormat:(NSString *)format
{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [df setDateFormat:format];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    return ci;
}

@end
