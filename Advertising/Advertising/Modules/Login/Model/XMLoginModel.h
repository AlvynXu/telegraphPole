//
//  XMLoginModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMUserModel : NSObject

@property(nonatomic, copy)NSString *phone;

@end

@interface XMLoginModel : NSObject

@property(nonatomic, assign)BOOL flag;  //是否是新用户

@property(nonatomic, copy)NSString *token;

@property(nonatomic, strong)XMUserModel *user;

@end

//

@interface XMUserRuleModel : NSObject

@property(nonatomic, copy)NSString *text;

@end


NS_ASSUME_NONNULL_END
