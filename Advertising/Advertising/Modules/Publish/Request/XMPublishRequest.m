//
//  XMPublishRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/20.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMPublishRequest.h"
#import "AFNetworking.h"

@implementation XMSaveBaseInfoRequest

- (NSString *)requestUrl
{
    return @"api/mallItemInfo/saveInfo";
}

- (id)requestArgument
{
    if (self.pId == -1992) {
        return @{@"categoryId":@(self.categoryId),@"description":self.desc, @"addressDetail":self.addressDetail, @"phone":self.phone};
    }else{
        return @{@"id":@(self.pId), @"categoryId":@(self.categoryId),@"description":self.desc, @"addressDetail":self.addressDetail, @"phone":self.phone};
    }
    
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:self.multipartFile name:@"multipartFile" fileName:@"multipartFile.png" mimeType:@"image/jpeg"];
    };
}


@end


@implementation XMSaveDetailInfoRequest

- (id)requestArgument
{
    if (self.type == 1) {
        return @{@"itemId":@(self.itemId), @"seq":@(self.seq), @"type":@(self.type)};
    }else{
        return @{@"itemId":@(self.itemId), @"seq":@(self.seq), @"type":@(self.type)};
    }
    
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        
        //@""
        if (self.type == 2) {
            [formData appendPartWithFileData:self.multipartFile name:@"multipartFile" fileName:@"multipartFile.png" mimeType:@"image/jpeg"];
        }else if(self.type == 3){
            
            [formData appendPartWithFileData:self.multipartFile name:@"multipartFile" fileName:@"multipartFile.mp4" mimeType:@"application/octet-stream"];
        }else{
            [formData appendPartWithFormData:[kFormat(@"%@", self.desc) dataUsingEncoding:NSUTF8StringEncoding] name:@"description"];
        }
        
        
    };
}


- (NSString *)requestUrl
{
    return @"api/mallItemInfo/saveInfoDetail";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}





@end
