//
//  XMAdvertModel.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMAdvertModel.h"

@implementation XMAdvertItemModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"desc":@"description", @"Id":@"id"};
}

- (UIColor *)statusColor
{
    UIColor *statusColor = kHexColor(0x808080);
    if (self.status == 3) {
        statusColor = kHexColor(0xff0101);
    }
    if (self.status == 0) {
        statusColor = kHexColor(0x03aa41);
    }
    if (self.status == 2) {
        statusColor =kHexColor(0x323232);
    }
    if (self.status == -1) {
        statusColor = kHexColor(0x999999);
    }
    return statusColor;
}


- (NSString *)statusStr
{
    NSString *tempStr;
    switch (self.status) {
        case -1:
            tempStr = @"未审核";
            break;
        case 0:
            tempStr = @"审核中";
            break;
        case 3:
            tempStr = @"发布中";
            break;
        case 2:
            tempStr = @"未发布";
            break;
            
        default:
            break;
    }
    return tempStr;
}

@end

@implementation XMAdvertModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"records":@"XMAdvertItemModel"};
}

@end
