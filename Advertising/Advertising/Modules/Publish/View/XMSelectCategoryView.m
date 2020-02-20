//
//  XMSelectCategoryView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/20.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMSelectCategoryView.h"
#import "XMGalleryRequest.h"

@interface XMSelectCategoryView()<UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong)UIView *blackBaseV;

@property(nonatomic, strong)UIView *frameCityV;

@property(nonatomic, strong)UIButton *cancelBtn;

@property(nonatomic, strong)UIButton *sureBtn;

@property(nonatomic, strong)UILabel *titleLbl;

@property(nonatomic, strong)UIPickerView *pickerV;

@property(nonatomic, assign)NSInteger selectRow;

@property(nonatomic, strong)NSArray *datas;

@property(nonatomic, strong)XMGalleryCategoryRequest *categoryRequest;   // 类目

@end

const CGFloat frameCategoryHeight = 298;

@implementation XMSelectCategoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self loadData];
    }
    return self;
}

- (void)setup
{
    [self.blackBaseV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.frameCityV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(frameCategoryHeight));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(frameCategoryHeight);
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
    
    [self.pickerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.frameCityV.mas_bottom);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(45.5);
        make.left.right.equalTo(self.frameCityV);
    }];
    
    @weakify(self)
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        // 隐藏
        [self hinde];
    }];
    
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        NSInteger row= [self.pickerV selectedRowInComponent:0];
        XMGalleryCateItemModel *cateItem = self.datas[row];
        if (cateItem) {
            [self.subject sendNext:@{@"title":cateItem.title, @"cateId":@(cateItem.Id)}];
        }
        // 隐藏
        [self hinde];
    }];
}

- (void)loadData
{
    @weakify(self)
    [self.categoryRequest startWithCompletion:^(__kindof XMGalleryCategoryRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMGalleryCateModel *cateModel = request.businessModel;
            self.datas = cateModel.data;
        }
        [self.pickerV reloadAllComponents];
    }];
}

#pragma mark  -----  UIPickerViewDelegate
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return self.datas.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    XMGalleryCateItemModel *item = self.datas[row];
    return item.title;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 100;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50.f;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
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
    _selectRow = row;
     [self.pickerV reloadAllComponents];   //一定要写这句
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
            make.bottom.equalTo(self.mas_bottom).offset(frameCategoryHeight);
        }];
        [self.frameCityV.superview layoutIfNeeded];//强制绘制
    } completion:^(BOOL finished) {
        self.blackBaseV.hidden = YES;
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
}


- (XMGalleryCategoryRequest *)categoryRequest
{
    if (!_categoryRequest) {
        _categoryRequest = [XMGalleryCategoryRequest request];
    }
    return _categoryRequest;
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
        _titleLbl.text = @"分类选择";
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


- (RACSubject *)subject
{
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}







@end
