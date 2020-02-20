//
//  RKMoreDisorderlyRequestVM.h
//  Refactoring
//
//  Created by dingqiankun on 2019/4/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMMoreDisorderlyRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMMoreDisorderlyVM : NSObject

@property(nonatomic, strong)RACCommand *upCmd;

@property(nonatomic, strong)RACCommand *downCmd;

@property(nonatomic, strong)XMMoreDisorderlyDownRequest *downRequest;

@property(nonatomic, strong)XMMoreDisorderlyUpRequest *upRequest;

@end

NS_ASSUME_NONNULL_END
