//
//  XMSelectAllCityView.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/3.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMSelectAllCityView.h"
#import "XMAllCityRequest.h"
#import "LYLocationUtil.h"

@interface XMSelectAllCityView()<UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong)UIPickerView *pickerV;

@property(nonatomic, strong)UIView *blackBaseV;

@property(nonatomic, strong)UIView *frameCityV;

@property(nonatomic, strong)UIButton *cancelBtn;

@property(nonatomic, strong)UIButton *sureBtn;

@property(nonatomic, strong)UILabel *titleLbl;

@property(nonatomic, strong)UIView *lineV;

@property(nonatomic, strong)XMAllCityRequest *allCityRequest;

@property(nonatomic, strong)NSArray *dataSource;

@property(nonatomic, assign)NSInteger selectRow;

@end

@implementation XMSelectAllCityView

CGFloat selectAllCityFrameHeight = 298;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self addClickEvent];
        [self loadData];
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
        make.height.equalTo(@(selectAllCityFrameHeight));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(selectAllCityFrameHeight);
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
}

#pragma mark   ------- UIPickerViewDelegate

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    XMAllCityItemModel *itemModel = self.dataSource[row];
    
    return itemModel.name;
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
    if (_selectRow == row) {
        pickerLabel.textColor = kMainColor;
    }else{
        pickerLabel.textColor = kHexColor(0x000000);
    }
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectRow = row;
    [pickerView reloadAllComponents];
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


#pragma mark ---- 默认城市
- (void)defaultSelect
{
    NSString *city = [LYLocationUtil getLocalCity];
    __block NSInteger cityIndex;
    
    [self.dataSource enumerateObjectsUsingBlock:^(XMAllCityItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:city]) {
            cityIndex = idx;
            *stop = YES;
        }
    }];
    [self.pickerV selectRow:cityIndex inComponent:0 animated:NO];
    self.selectRow = cityIndex;
}


#pragma mark ---- 添加d单击事件
- (void)addClickEvent
{
    @weakify(self)
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self hinde];
    }];
    
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self hinde];
        NSInteger row = [self.pickerV selectedRowInComponent:0];
        XMAllCityItemModel *itemModel = self.dataSource[row];
        NSString *name = itemModel.name;
        NSString *code = itemModel.code;
        [self.subject sendNext:@{@"name":name, @"code":code}];
    }];
}


#pragma mark  -------  加载数据
- (void)loadData
{
    @weakify(self)
    [self.allCityRequest startWithCompletion:^(__kindof XMAllCityRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMAllCityModel *model = request.businessModel;
            self.dataSource = model.data;
            [self.pickerV reloadAllComponents];
            [self defaultSelect];
        }
    }];
}

#pragma mark  ------- 显示 消失事件
- (void)show
{
    if (!self.superview) {
        [kWindow addSubview:self];
    }
    self.blackBaseV.hidden = NO;
    
    [self.frameCityV.superview layoutIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.frameCityV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        [self.frameCityV.superview layoutIfNeeded];//强制绘制
    }];
}

- (void)hinde
{
    [self.frameCityV.superview layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.frameCityV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(selectAllCityFrameHeight);
        }];
        [self.frameCityV.superview layoutIfNeeded];//强制绘制
    } completion:^(BOOL finished) {
        self.blackBaseV.hidden = YES;
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
}


- (XMAllCityRequest *)allCityRequest
{
    if (!_allCityRequest) {
        _allCityRequest = [XMAllCityRequest request];
    }
    return _allCityRequest;
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


@end
