//
//  XMAreaSelectVm.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMAreaSelectVm.h"
#import "LYLocationUtil.h"

@interface XMAreaSelectVm ()

@property(nonatomic, copy)NSString *code;

@property(nonatomic, strong)XMParentRequest *parentRequest;

@property(nonatomic, strong)XMCityRequest *cityRequest;

@property(nonatomic, strong)XMCountyRequest *countyRequest;

@property(nonatomic, strong)XMStreetRequest *streetRequest;

@end

@implementation XMAreaSelectVm

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
    @weakify(self)
    [self.parentRequest startWithCompletion:^(__kindof XMParentRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMAreaCommonModel *model = request.businessModel;
            if ([model.data count] == 0) {
                [self.parentArray removeAllObjects];
                [self.cityArray removeAllObjects];
                [self.countyArray removeAllObjects];
                [self.streetArray removeAllObjects];
                [self.subject sendNext:@""];
            }else{
                if (!self.isdefaultFirst) {
                    self.isdefaultFirst = YES;
                    self.parentArray = model.data;
                    self.code =[self getFirstDefault];
                    NSLog(@"---------- %@", self.code);
                    // 如果code为空继续请求
                    if ([self.code isEmpty]) {
                        [self setup];
                    }
                    [self getCityWith:self.code];
                }else{
                    XMAreaItemModel *itemModel = model.data.firstObject;
                    self.code = itemModel.code;
                    self.parentArray = model.data;
                    [self getCityWith:self.code];
                }
                
            }
        }
    }];
}

- (void)getCityWith:(NSString *)code
{
    if ([code isEmpty]) {
        return;
    }
    self.cityRequest.code = code;
    @weakify(self)
    [self.cityRequest startWithCompletion:^(__kindof XMCityRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMAreaCommonModel *model = request.businessModel;
            XMAreaItemModel *itemModel = model.data.firstObject;
            if ([model.data count] == 0) {
                [self.cityArray removeAllObjects];
                [self.countyArray removeAllObjects];
                [self.streetArray removeAllObjects];
                [self.subject sendNext:@""];
            }else{
                self.code = itemModel.code;
                self.cityArray = model.data;
                [self getCountWith:self.code];
            }
        }
        
    }];
}

- (void)getCountWith:(NSString *)code
{
    if ([code isEmpty]) {
        return;
    }
    self.countyRequest.code = code;
    @weakify(self)
     [self.countyRequest startWithCompletion:^(__kindof XMCountyRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMAreaCommonModel *model = request.businessModel;
            if ([model.data count] == 0) {
                [self.countyArray removeAllObjects];
                [self.streetArray removeAllObjects];
                [self.subject sendNext:@""];
            }else{
                self.countyArray = model.data;
                XMAreaItemModel *itemModel = model.data.firstObject;
                self.code = itemModel.code;
                [self getStreetWith:self.code];
            }
        }
    }];
}

- (void)getStreetWith:(NSString *)code
{
    if ([code isEmpty]) {
        return;
    }
    @weakify(self)
    self.streetRequest.code = code;
    [self.streetRequest startWithCompletion:^(__kindof XMStreetRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMStreetModel *model = request.businessModel;
            self.streetArray = model.data;
            // 判断当前城市是否有数据
            [self.subject sendNext:@""];
        }
       
    }];
}


- (void)getCurrentArray:(NSArray *)cityArray CodeWith:(NSString *)cityName
{

    for (XMAreaItemModel *itemModel in cityArray) {
        if ([itemModel.name isEqualToString:cityName]) {
            self.code = itemModel.code;
            break;
        }
    }
}

//
- (NSString *)getFirstDefault
{
    NSString *paraent = [LYLocationUtil getLocalParaent];
    __block NSString *code;
    [self.parentArray enumerateObjectsUsingBlock:^(XMAreaItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:paraent]) {
            code = obj.code;
            *stop = YES;
        }
    }];
    return code;
}


- (XMParentRequest *)parentRequest
{
    if (!_parentRequest) {
        _parentRequest = [XMParentRequest request];
    }
    return _parentRequest;
}

- (XMCityRequest *)cityRequest
{
    if (!_cityRequest) {
        _cityRequest = [XMCityRequest request];
    }
    return _cityRequest;
}

- (XMCountyRequest *)countyRequest
{
    if (!_countyRequest) {
        _countyRequest = [XMCountyRequest request];
    }
    return _countyRequest;
}

- (XMStreetRequest *)streetRequest
{
    if (!_streetRequest) {
        _streetRequest = [XMStreetRequest request];
    }
    return _streetRequest;
}

- (RACSubject *)subject
{
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}

@end
