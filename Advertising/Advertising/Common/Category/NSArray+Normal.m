//
//  NSArray+Normal.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/1.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "NSArray+Normal.h"

@implementation NSArray (Normal)

- (BOOL)isEmptyArray
{
    if (self != nil && ![self isKindOfClass:[NSNull class]] && self.count != 0)
    {
        return NO;
    }else {
        return YES;
    }
}

@end
