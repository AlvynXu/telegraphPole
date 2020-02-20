//
//  RKEmptyView.m
//  Refactoring
//
//  Created by dingqiankun on 2019/5/23.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMEmptyView.h"

@interface XMEmptyView()

@property(nonatomic, strong)UIImageView *imageV;

@property(nonatomic, strong)UILabel *titleLbl;

@property(nonatomic, strong)UILabel *detailLbl;

@property(nonatomic, strong)UIButton *btn;

@property(nonatomic, strong)NSMutableDictionary *saveSateDict;

@end

@implementation XMEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    CGFloat offsetY = -80;
    CGFloat topMargin = 10;
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(offsetY);
        make.size.mas_equalTo(CGSizeMake(84, 64));
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(kScreenWidth - 40));
        make.top.equalTo(self.imageV.mas_bottom).offset(topMargin);
    }];
    
    [self.detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(topMargin);
        make.width.equalTo(self.titleLbl.mas_width);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.detailLbl.mas_bottom).offset(topMargin);
        make.size.mas_equalTo(CGSizeMake(120, 35));
    }];
}


- (void)setImage:(NSString *)name forState:(EmptySate)state
{
    [self.saveSateDict setValue:name forKey:kFormat(@"img_%@", @(state))];
    [self showWith:state];
}

- (void)setTitile:(NSString *)titile forState:(EmptySate)state
{
    [self.saveSateDict setValue:titile forKey:kFormat(@"title_%@", @(state))];
    [self showWith:state];
}

- (void)setDetail:(NSString *)titile forState:(EmptySate)state
{
    [self.saveSateDict setValue:titile forKey:kFormat(@"detail_%@", @(state))];
    
    
    [self showWith:state];
}

- (void)setBtnTitle:(NSString *)titile forState:(EmptySate)state
{
    [self.saveSateDict setValue:titile forKey:kFormat(@"btn_%@", @(state))];
    [self showWith:state];
}

- (void)setStateWithNormal
{
    if (self.superview) {
        [self removeFromSuperview];
    }
}

- (void)showWith:(EmptySate)state
{
    NSString *currentImgState = kFormat(@"img_%@", @(state));
    self.imageV.image = kGetImage([self valueForSaveSateDictWith:currentImgState andSate:state]);
    NSString *currentTitleState = kFormat(@"title_%@", @(state));
    self.titleLbl.text = [self valueForSaveSateDictWith:currentTitleState andSate:state];
    NSString *currentDetailState = kFormat(@"detail_%@", @(state));
    self.detailLbl.text = [self valueForSaveSateDictWith:currentDetailState andSate:state];
    NSString *currentBtnTitleState = kFormat(@"btn_%@", @(state));
    [self.btn setTitle:[self valueForSaveSateDictWith:currentBtnTitleState andSate:state] forState:UIControlStateNormal];
}

- (NSString *)valueForSaveSateDictWith:(NSString *)key andSate:(EmptySate)state
{
    NSString *value = [self.saveSateDict valueForKey:key];
    if (!value) {
        if (state == EmptySateNetWorkError) {  // 网络错误
            if ([key containsString:@"img"]) {
                value = @"network-icon";
            }else if ([key containsString:@"detail"]) {
                value = @"当前网络不可用,请检查网络设置";
            }
            [self.imageV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(64, 51));
            }];
        } else if (state == EmptySateServerError) {   // 服务器错误
            if ([key containsString:@"img"]) {
                value = @"server-error";
            }else if ([key containsString:@"title"]) {
                value = @"";
            }else if ([key containsString:@"detail"]) {
                value = @"服务器连接失败，稍后重试";
            }
            [self.imageV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(64, 64));
            }];
        } else if (state == EmptySateEmptyData) {   // 查询数据为空
            if ([key containsString:@"img"]) {
                value = @"no-data";
            }else if ([key containsString:@"title"]) {
               value = @"";
            } else if ([key containsString:@"detail"]) {
                value = @"没有找到你要查询的数据";
            }
            [self.imageV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(104, 62));
            }];
        } else {
            if ([key containsString:@"img"]) {
               value = @"";
            }else if ([key containsString:@"title"]) {
                value = @"";
            }
        }
       
    }
    return value;
}


#pragma mark  ------ 懒加载

- (UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        [self addSubview:_imageV];
    }
    return _imageV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _detailLbl.font = kSysFont(15);
        _titleLbl.numberOfLines = 0;
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)detailLbl
{
    if (!_detailLbl) {
        _detailLbl = [[UILabel alloc] init];
        _detailLbl.textAlignment = NSTextAlignmentCenter;
        _detailLbl.numberOfLines = 0;
        _detailLbl.font = kSysFont(14);
        _detailLbl.textColor = kDisEnableColor;
        [self addSubview:_detailLbl];
    }
    return _detailLbl;
}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_btn];
    }
    return _btn;
}

- (NSMutableDictionary *)saveSateDict
{
    if (!_saveSateDict) {
        _saveSateDict = [NSMutableDictionary dictionaryWithCapacity:30];
    }
    return _saveSateDict;
}


@end
