//
//  NSNumber+FlickerNumber.h
//  StoneMoney
//
//  Created by 陈小东 on 15/6/16.
//  Copyright (c) 2015年 杭州时投信息科技@陈小东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (FlickerNumber)

#define IsNotANumber(num) [NSDecimalNumber.notANumber isEqualToNumber:num]
#define IsZerorNumber(num) [NSDecimalNumber.zero isEqualToNumber:num]
#define IsNotANumberOrZero(num) IsNotANumber(num) || IsZerorNumber(num)
//两位小数
- (NSString *)formatNumberDecimal;
//四位小数
- (NSString *)formatNumberDecimalWithFour;
// 千分号 显示
- (NSString *)formatNumberNo;
// 千分号 显示 四位
- (NSString *)formatNumberNoTwo;

//四舍五入保留4位
- (NSString *)formatNumbeWithFour;
//四舍五入保留2位
- (NSString *)formatNumberWithTow;

@end
@interface NSString(Round)

- (NSString *)divideByNum:(NSString *)num;
- (NSString *)multiplyingByNum:(NSString *)num;
- (NSString *)subtractNum:(NSString *)num;
- (NSString *)addNum:(NSString *)num;
- (BOOL)isDigitSizeInScale:(short)scale;
- (NSString *)roundByScale:(short)scale roundMode:(NSRoundingMode)roundMode;

- (NSString *)prettyReadNumber;
- (NSString *)prettyReadPrice;

@end
@interface NSDecimalNumber(Round)

- (NSDecimalNumber *)roundByScale:(short)scale roundMode:(NSRoundingMode)roundMode;

@end

@interface NSDecimalNumber(Normal)

+ (NSComparisonResult)compareStringA:(NSString *)a stringB:(NSString *)b;
+ (NSComparisonResult)compareStringA:(NSString *)a floatB:(CGFloat)b;
@end
