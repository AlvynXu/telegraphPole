//
//  RKMoreDisorderlyRequestVM.m
//  Refactoring
//
//  Created by dingqiankun on 2019/4/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMoreDisorderlyVM.h"

@interface XMMoreDisorderlyVM ()

@end


@implementation XMMoreDisorderlyVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self.upCmd = [RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return self.upRequest.requestSignal;
    }];
    
    [self.downCmd = [RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return self.downRequest.requestSignal;
    }];
}

- (XMMoreDisorderlyDownRequest *)downRequest
{
    if (!_downRequest) {
        _downRequest = [XMMoreDisorderlyDownRequest request];
    }
    return _downRequest;
}

- (XMMoreDisorderlyUpRequest *)upRequest
{
    if (!_upRequest) {
        _upRequest = [XMMoreDisorderlyUpRequest request];
    }
    return _upRequest;
}


@end
