//
//  NSNumber+FlickerNumber.m
//  StoneMoney
//
//  Created by 陈小东 on 15/6/16.
//  Copyright (c) 2015年 杭州时投信息科技@陈小东. All rights reserved.
//

#import "NSNumber+FlickerNumber.h"

@implementation NSNumber (FlickerNumber)

- (NSString *)formatNumberDecimal{
    if(self){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.roundingMode = kCFNumberFormatterRoundFloor;
//        formatter.numberStyle = kCFNumberFormatterDecimalStyle;
        [formatter setMaximumFractionDigits:2];
        return [formatter stringFromNumber:self];
    }
    return @"0";
}

- (NSString *)formatNumberDecimalWithFour{
    if(self){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.roundingMode = kCFNumberFormatterRoundFloor;
        formatter.numberStyle = NSNumberFormatterNoStyle;
        [formatter setMaximumFractionDigits:4];
        return [formatter stringFromNumber:self];
    }
    return @"0";
}

- (NSString *)formatNumberNo{
    if(self){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.roundingMode = kCFNumberFormatterRoundFloor;
        [formatter setMaximumFractionDigits:4];
        return [formatter stringFromNumber:self];
    }
    return @"0";
}

- (NSString *)formatNumberNoTwo{
    if(self){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.roundingMode = kCFNumberFormatterRoundFloor;
        [formatter setMaximumFractionDigits:2];
        return [formatter stringFromNumber:self];
    }
    return @"0";
}

- (NSString *)formatNumbeWithFour{
    if(self){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.roundingMode = kCFNumberFormatterRoundHalfUp;
        [formatter setMaximumFractionDigits:4];
        [formatter setMinimumFractionDigits:4];
        return [formatter stringFromNumber:self];
    }
    return @"0";
}

- (NSString *)formatNumberWithTow{
    if(self){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.roundingMode = kCFNumberFormatterRoundHalfUp;
        [formatter setMinimumFractionDigits:2];
        [formatter setMaximumFractionDigits:2];
        return [formatter stringFromNumber:self];
    }
    return @"0.00";
}
//是否是整数
- (BOOL)multipleLongForNumber{
    NSString *str = [NSString stringWithFormat:@"%@",self];
    if([str rangeOfString:@"."].location == NSNotFound){
        return YES;
    }
    return NO;
}

@end

@implementation NSDecimalNumber(Round)
- (NSDecimalNumber *)roundByScale:(short)scale roundMode:(NSRoundingMode)roundMode{
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundMode scale:scale raiseOnExactness:NO
                                                                                    raiseOnOverflow:NO
                                                                                   raiseOnUnderflow:NO
                                                                                raiseOnDivideByZero:YES];
    return [self decimalNumberByRoundingAccordingToBehavior:behavior];
}
@end
@implementation NSString(Round)

- (NSArray <NSDecimalNumber *>*)checkWithNumber:(NSString *)num{
    NSDecimalNumber *decimalA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *decimalB = [NSDecimalNumber decimalNumberWithString:num];
    if (IsNotANumber(decimalA) || IsNotANumber(decimalB)) {
        return nil;
    }
    return @[decimalA,decimalB];
}

- (NSString *)subtractNum:(NSString *)num{
    NSArray *result =[self checkWithNumber:num];
    if (result) {
        return [result.firstObject decimalNumberBySubtracting:result.lastObject].stringValue;
    }
    return nil;
}

- (NSString *)divideByNum:(NSString *)num{
    NSArray *result =[self checkWithNumber:num];
    if (result) {
        return [result.firstObject decimalNumberByDividingBy:result.lastObject].stringValue;
    }
    return nil;
}

- (NSString *)addNum:(NSString *)num{
    NSArray *result =[self checkWithNumber:num];
    if (result) {
        return [result.firstObject decimalNumberByAdding:result.lastObject].stringValue;
    }
    return nil;
}

- (NSString *)multiplyingByNum:(NSString *)num{
    NSArray *result =[self checkWithNumber:num];
    if (result) {
        return [result.firstObject decimalNumberByMultiplyingBy:result.lastObject].stringValue;
    }
    return nil;
}
- (BOOL)isDigitSizeInScale:(short)scale{
    
    if ([self hasPrefix:@"."]) {
        return NO;
    }
    if ([self hasPrefix:@"00"]) {
        return NO;
    }
    NSArray *intDigit = [self componentsSeparatedByString:@"."];
    if (intDigit.count!=2 && [self containsString:@"."]) {
        return NO;
    }
    NSString *digits = intDigit.count>1 ? intDigit.lastObject:@"";
    return digits.length <= scale;
}
- (NSString *)roundByScale:(short)scale roundMode:(NSRoundingMode)roundMode{
     NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:self];
    if (IsNotANumber(decimal)) {
        return nil;
    }
    NSDecimalNumber *roundDecimal = [decimal roundByScale:scale roundMode:roundMode];
    return roundDecimal.stringValue;
}

- (NSString *)prettyReadNumber{
    NSDecimalNumber *number=[NSDecimalNumber decimalNumberWithString:self];
    if (IsNotANumber(number))
        return @"";
    
    long long num = [number longLongValue];
    if (num < 1000)
        return self;
    int s = ( (num < 0) ? -1 : (num > 0) ? 1 : 0 );
    NSString* sign = (s == -1 ? @"-" : @"" );
    
    num = llabs(num);

    int exp = (int) (log10l(num) / 3.f); //log10l(1000));
    
    NSArray* units = @[@"K",@"M",@"B"];
    
    return [NSString stringWithFormat:@"%@%.1f%@",sign, (num / pow(1000, exp)), [units objectAtIndex:(exp-1)]];
    
}

- (NSString *)prettyReadPrice{
    NSDecimalNumber *number=[NSDecimalNumber decimalNumberWithString:self];
    if (IsNotANumber(number))
        return @"";
    
    long long num = [number longLongValue];
    if (num < 100)
        return self;
    else if (num>=100 && num < 999){
        return [self roundByScale:4 roundMode:NSRoundDown];
    }else{
        return [self roundByScale:2 roundMode:NSRoundDown];
    }
}

@end

@implementation NSDecimalNumber(Normal)



+ (NSComparisonResult)compareStringA:(NSString *)a stringB:(NSString *)b{
    NSDecimalNumber *decA = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *decB = [NSDecimalNumber decimalNumberWithString:b];
    return [decA compare:decB];
}

+ (NSComparisonResult)compareStringA:(NSString *)a floatB:(CGFloat)b{
    NSDecimalNumber *decA = [NSDecimalNumber decimalNumberWithString:a];
    NSNumber *decB = [NSNumber numberWithDouble:b];
    return [decA compare:decB];
}

@end
