//
//  XMHomeMsgModel.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMHomeMsgModel.h"

@implementation XMHomeMsgModel

@end


@implementation XMHomeBootModel

- (NSString *)noSoldCount
{
    if ([self.totalCount isEmpty]) {
        return @"0";
    }
    NSInteger noSold = self.totalCount.integerValue - self.soldCount.integerValue;
    return kFormat(@"%zd", noSold);
}

@end
