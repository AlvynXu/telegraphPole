//
//  XMSelectCityView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMSelectCityView.h"
#import "XMAreaSelectModel.h"
#import "LYLocationUtil.h"
#import "XMAreaSelectVm.h"

@interface XMSelectCityView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong)UIView *blackBaseV;

@property(nonatomic, strong)UIView *frameCityV;

@property(nonatomic, strong)UIButton *cancelBtn;

@property(nonatomic, strong)UIButton *sureBtn;

@property(nonatomic, strong)UILabel *titleLbl;

@property(nonatomic, strong)UIView *lineV;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, strong)NSDictionary *selectDict;


@property(nonatomic, assign)NSInteger selectComponent;  // 被选中的列
@property(nonatomic, assign)NSInteger selectRow;  // 被选中row

@property(nonatomic, assign)BOOL defaultFirst;  // 默认第一次根据定位来


@property(nonatomic, strong)XMAreaSelectVm *areaSlelctVm;
@property(nonatomic, assign)NSInteger refreshIndexArea;  // 刷新区域


@end

@implementation XMSelectCityView

const CGFloat frameCityHeight = 298;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
    }
    return self;
}


// 初始化
- (void)setup
{
    [self.blackBaseV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.frameCityV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(frameCityHeight));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(frameCityHeight);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28.5);
        make.top.equalTo(@23);
        make.width.equalTo(@35);
        make.height.equalTo(@18);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancelBtn.mas_centerY);
        make.height.equalTo(@18);
        make.width.equalTo(@80);
        make.centerX.equalTo(self.frameCityV.mas_centerX);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-28.5);
        make.height.equalTo(@18);
        make.width.equalTo(@50);
        make.centerY.equalTo(self.titleLbl.mas_centerY);
    }];
    
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.frameCityV);
        make.height.equalTo(@1);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(20);
    }];
    
    [self.pickerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.frameCityV.mas_bottom);
        make.top.equalTo(self.lineV.mas_bottom).offset(25.5);
        make.left.right.equalTo(self.frameCityV);
    }];
    
    @weakify(self)
    [self.areaSlelctVm.subject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.parentArray = self.areaSlelctVm.parentArray;
        self.cityArray = self.areaSlelctVm.cityArray;
        self.countArray = self.areaSlelctVm.countyArray;
        self.streetArray = self.areaSlelctVm.streetArray;
        if (self.refreshIndexArea == 0) {  // 如果选择省份刷新全部
            [self.pickerV reloadAllComponents];
            if (!self.defaultFirst) {
                self.defaultFirst = YES;
                [self defaultSelect];
            }
        }else{  //  选择其他部分默认刷新
            while (self.refreshIndexArea < 4) {
                [self.pickerV reloadComponent:self.refreshIndexArea];
                self.refreshIndexArea =  self.refreshIndexArea+1;
            }
        }
    }];
    
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        // 隐藏
        [self hinde];
    }];
    
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.selectDict && self.selectDict.allKeys.count > 0) {
            [self.subject sendNext:self.selectDict];
        }
        // 隐藏
        [self hinde];
    }];
}

- (void)defaultSelect
{
    NSString *city = [LYLocationUtil getLocalCity];
    NSString *paraent = [LYLocationUtil getLocalParaent];
    __block NSInteger paraentIndex;
    __block NSInteger cityIndex;
   
    [self.cityArray enumerateObjectsUsingBlock:^(XMAreaItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:city]) {
            cityIndex = idx;
            *stop = YES;
        }
    }];
    
    [self.parentArray enumerateObjectsUsingBlock:^(XMAreaItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:paraent]) {
            paraentIndex = idx;
            *stop = YES;
        }
    }];
    
    [self.pickerV selectRow:paraentIndex inComponent:0 animated:YES];
    [self.pickerV selectRow:cityIndex inComponent:1 animated:YES];
    self.selectComponent = 1;
    self.selectRow = cityIndex;
}

- (void)show
{
    if (!self.superview) {
        [kWindow addSubview:self];
    }
    self.blackBaseV.hidden = NO;
    [self.frameCityV.superview layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.frameCityV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.safeEqualToBottom(self);
        }];
        [self.frameCityV.superview layoutIfNeeded];//强制绘制
    }];
}

- (void)hinde
{
    [self.frameCityV.superview layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.frameCityV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(frameCityHeight);
        }];
    } completion:^(BOOL finished) {
        self.blackBaseV.hidden = YES;
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
    [self.frameCityV.superview layoutIfNeeded];//强制绘制
}

- (void)selectCityWith:(NSDictionary *)dict
{
    NSString *code = dict[@"code"];
    NSInteger index = [dict[@"index"] integerValue];
    if (index == 0) { // 选择省
        [self.areaSlelctVm getCityWith:code];
       
    }
    if (index == 1) {  //选择市
        [self.areaSlelctVm getCountWith:code];
        
    }
    if (index == 2) { //选择县
        [self.areaSlelctVm getStreetWith:code];
    }
}
#pragma mark  -----  UIPickerViewDelegate
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 3) {
        return [self.streetArray isEmptyArray]?0:self.streetArray.count;
    }
    if (component == 2) {
        return [self.countArray isEmptyArray]?0:self.countArray.count;
    }
    if (component == 1) {
        return [self.cityArray isEmptyArray]?0:self.cityArray.count;
    }
    if (component == 0) {
        return [self.parentArray isEmptyArray]?0:self.parentArray.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 3) {
        XMStreetItemModel *item = [self.streetArray isEmptyArray]?@"":self.streetArray[row];
        return item.name;
    }
    if (component == 2) {
        XMAreaItemModel *item = [self.countArray isEmptyArray]?@"":self.countArray[row];
        return item.name;
    }
    if (component == 1) {
        XMAreaItemModel *item = [self.cityArray isEmptyArray]?@"":self.cityArray[row];
        return item.name;
    }
    if (component == 0) {
        XMAreaItemModel *itemParent = [self.parentArray isEmptyArray]?@"":self.parentArray[row];
        return itemParent.name;
    }
    return @"";
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (_level == XMLevelFour) {
        return 75;
    }else if (_level == XMLevelThree){
        return 100;
    }else{
        return 150;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50.f;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _level;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        pickerLabel.font = kSysFont(14);
        [pickerLabel setBackgroundColor: [UIColor clearColor]];
    }
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    if (_selectComponent == component) {
        if (_selectRow == row) {
             pickerLabel.textColor = kMainColor;
        }else{
            pickerLabel.textColor = kHexColor(0x000000);
        }
    }else{
        pickerLabel.textColor = kHexColor(0x000000);
    }
    return pickerLabel;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectRow = row;
    _selectComponent = component;
    [self.pickerV reloadAllComponents];   //一定要写这句
    
    NSString *code = @"";
    NSInteger index = component;
    if (component == 3) {
        if (![self.streetArray isEmptyArray]) {
            XMStreetItemModel *item = self.streetArray[row];
            code = item.code;
            self.name = item.name;
        }
       
    }
    if (component == 2) {
        if (![self.countArray isEmptyArray]) {
            XMAreaItemModel *item = self.countArray[row];
            code = item.code;
            self.name = item.name;
        }
    }
    if (component == 1) {
        if (![self.cityArray isEmptyArray]) {
            XMAreaItemModel *item =self.cityArray[row];
            self.name = item.name;
            code = item.code;
        }
    }
    if (component == 0) {
        if (![self.parentArray isEmptyArray]) {
            XMAreaItemModel *itemParent = self.parentArray[row];
            code = itemParent.code;
            self.name = itemParent.name;
        }
    }
    if (![code isEmpty] && ![self.name isEmpty]) {
        // 刷新下一级地区
        [self selectCityWith:@{@"code": code, @"index": @(index)}];
        self.selectDict = @{@"code": code, @"index": @(index), @"name":[self getSelectRowName]};
       
    }
}

- (NSString *)getSelectRowName
{
    NSMutableString *allNameStr = [NSMutableString string];
    for (NSInteger i = 0; i<=self.selectComponent; i++) {
        NSInteger row= [self.pickerV selectedRowInComponent:i];
        if (i == 0) {
            XMAreaItemModel *item = self.parentArray[row];
            NSString *parent = item.name;
            [allNameStr appendString:kFormat(@" %@", parent)];
        }
        if (i == 1) {
            XMAreaItemModel *item = self.cityArray[row];
            NSString *city = item.name;
            [allNameStr appendString:kFormat(@" %@", city)];
        }
        if (i == 2) {
            XMAreaItemModel *item = self.countArray[row];
            NSString *count = item.name;
            [allNameStr appendString:kFormat(@" %@", count)];
        }
        if (i == 3) {
            XMAreaItemModel *item = self.streetArray[row];
            NSString *street = item.name;
            [allNameStr appendString:kFormat(@" %@", street)];
        }
    }
    return [allNameStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (UIView *)frameCityV
{
    if (!_frameCityV) {
        _frameCityV = [[UIView alloc] init];
        _frameCityV.backgroundColor = UIColor.whiteColor;
        [self.blackBaseV addSubview:_frameCityV];
    }
    return _frameCityV;
}

- (UIPickerView *)pickerV
{
    if (!_pickerV) {
        _pickerV = [[UIPickerView alloc] init];
        _pickerV.delegate = self;
        _pickerV.delegate = self;
        [self.frameCityV addSubview:_pickerV];
    }
    return _pickerV;
}

- (UIView *)blackBaseV
{
    if (!_blackBaseV) {
        _blackBaseV = [[UIView alloc] init];
        _blackBaseV.backgroundColor = kHexColorA(0x000000, 0.87);
        [self addSubview:_blackBaseV];
    }
    return _blackBaseV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = kHexColor(0xFF333333);
        _titleLbl.font = kSysFont(18);
        _titleLbl.text = @"地址选择";
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        [self.frameCityV addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:kHexColor(0xFF999999) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = kSysFont(17);
        [self.frameCityV addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:kHexColor(0xFF8BC34A) forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = kSysFont(17);
        [self.frameCityV addSubview:_sureBtn];
    }
    return _sureBtn;
}

- (UIView *)lineV
{
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = kHexColor(0xFFCDCDCD);
        [self.frameCityV addSubview:_lineV];
    }
    return _lineV;
}

- (RACSubject *)subject
{
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}



- (XMAreaSelectVm *)areaSlelctVm
{
    if (!_areaSlelctVm) {
        _areaSlelctVm = [XMAreaSelectVm new];
    }
    return _areaSlelctVm;
}

@end
