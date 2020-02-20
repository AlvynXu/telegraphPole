//
//  XMRecordsModel.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMRecordsModel.h"

@implementation XMLanlordRecordsItemModel

@end

@implementation XMLanlordRecordModel

@end

@implementation XMBoothRecordsItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"desc":@"description", @"id":@"Id"};
}

- (CGFloat)cellHeight
{
    switch (self.useStatus) {
        case 6:   // 广告
            return 133;
            break;
        case 4:   // 已租
        case 5: // 租用
            return 161;
            break;
        default: 
            return 91;
            break;
    }
}

- (NSString *)statusStr
{
    switch (self.useStatus) {
        case 1:  // 闲置
            return @"闲置";
            break;
        case 6:   // 广告
            return @"广告";
            break;
        case 4:  // 已租
            return @"已租";
            break;
        case 5: // 租用
            return @"租用";
            break;
        default:  // 待租 目前此状态没有
            return @"待租";
            break;
    }
}

- (UIColor *)statusColor
{
    switch (self.useStatus) {
        case 1:  // 闲置
            return kHexColor(0xFFF85F53);
            break;
        case 6:   // 广告
            return kHexColor(0xFF85C05D);
            break;
        case 4:  // 租用
            return kHexColor(0xFFF2A016);
            break;
        case 5: // 已租
            return kHexColor(0xFF000000);
            break;
        default:  // 待租 目前此状态没有
            return kHexColor(0x000000);
            break;
    }
}



@end

@implementation XMBoothRecordModel

@end

//
@implementation XMBoothRecordGetNumModel

@end


