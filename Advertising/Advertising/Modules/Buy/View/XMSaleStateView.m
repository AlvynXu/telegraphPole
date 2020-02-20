//
//  XMSaleStateView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMSaleStateView.h"

@interface XMSaleStateView ()

@property(nonatomic, strong)UIView *blackBaseV;

@property(nonatomic, strong)UIView *frameStateV;

@property(nonatomic, strong)UIButton *cancelBtn;

@property(nonatomic, strong)UIButton *sureBtn;

@property(nonatomic, strong)UILabel *titleLbl;

@property(nonatomic, strong)UIButton *noSellBtn;

@property(nonatomic, strong)UIButton *selledBtn;


// 选中参数
@property(nonatomic, copy)NSString *titleStr; // 选中标题

@property(nonatomic, assign)NSInteger index;  // 被选中下标

@property(nonatomic, strong)UIButton *selectBtn; // 当前选中按钮

@property(nonatomic, strong)UIButton *defaultBtn; // 未点击确定按钮

@end

@implementation XMSaleStateView

const CGFloat frameStateHeight = 261;

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
    
    [self.blackBaseV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.frameStateV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(frameStateHeight));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(frameStateHeight);
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
        make.centerX.equalTo(self.frameStateV.mas_centerX);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-28.5);
        make.height.equalTo(@18);
        make.width.equalTo(@50);
        make.centerY.equalTo(self.titleLbl.mas_centerY);
    }];
    
    UIView *lineV = [UIView new];
    lineV.backgroundColor = kHexColor(0xFFCDCDCD);
    [self.frameStateV addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.frameStateV);
        make.height.equalTo(@1);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(20);
    }];
    
    [self.noSellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(self.frameStateV.mas_right).offset(-15);
        make.height.equalTo(@70);
        make.top.equalTo(lineV.mas_bottom).offset(14);
    }];
    
    UIView *lineV1 = [UIView new];
    lineV1.backgroundColor = kHexColor(0xFFCDCDCD);
    [self.frameStateV addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.frameStateV.mas_centerX);
        make.width.equalTo(@(250));
        make.height.equalTo(@1);
        make.top.equalTo(self.noSellBtn.mas_bottom);
    }];
    
    [self.selledBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(self.frameStateV.mas_right).offset(-15);
        make.height.equalTo(@70);
        make.top.equalTo(lineV1.mas_bottom);
    }];
    
    UIView *lineV2 = [UIView new];
    lineV2.backgroundColor = kHexColor(0xFFCDCDCD);
    [self.frameStateV addSubview:lineV2];
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.frameStateV.mas_centerX);
        make.width.equalTo(@(250));
        make.height.equalTo(@1);
        make.top.equalTo(self.selledBtn.mas_bottom);
    }];
    
    @weakify(self)
    // 已售
    [[self.selledBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self)
        if (self.selectBtn != x) {
            [self.selectBtn setSelected:NO];
        }
        [x setSelected:YES];
        self.selectBtn = x;
    }];
    
    // 未售
    
    [[self.noSellBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self)
        if (self.selectBtn != x) {
            [self.selectBtn setSelected:NO];
        }
        [x setSelected:YES];
        self.selectBtn = x;
    }];
    
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        // 隐藏
        [self hinde];
    }];
    
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        // 隐藏
        [self seletItemWith:self.selectBtn];
        [self hinde];
        
    }];
}

- (void)seletItemWith:(UIButton *)x
{
    self.defaultBtn = x;
    NSInteger index = x.tag - 300;
    NSString *title = [x titleForState:UIControlStateSelected];
    NSDictionary *dict = @{@"title": title, @"index":@(index)};
    [self.selectBlockSub sendNext:dict];
}


- (void)show
{
    if (!self.superview) {
        [kWindow addSubview:self];
    }
    self.blackBaseV.hidden = NO;
    
    [self.frameStateV.superview layoutIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.frameStateV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        [self.frameStateV.superview layoutIfNeeded];//强制绘制
    }];
    
    if (self.defaultBtn != self.selectBtn) {
        [self.selectBtn setSelected:NO];
        [self.defaultBtn setSelected:YES];
        self.selectBtn = self.defaultBtn;
    }
    
    
   
}

- (void)hinde
{
    [self.frameStateV.superview layoutIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.frameStateV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(frameStateHeight);
        }];
        
        [self.frameStateV.superview layoutIfNeeded];//强制绘制
    } completion:^(BOOL finished) {
        self.blackBaseV.hidden = YES;
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
    
    
    
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

- (UIView *)frameStateV
{
    if (!_frameStateV) {
        _frameStateV = [[UIView alloc] init];
        _frameStateV.backgroundColor = UIColor.whiteColor;
        [self.blackBaseV addSubview:_frameStateV];
    }
    return _frameStateV;
}


- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:kHexColor(0xFF999999) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = kSysFont(17);
        [self.frameStateV addSubview:_cancelBtn];
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
        [self.frameStateV addSubview:_sureBtn];
    }
    return _sureBtn;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = kHexColor(0xFF333333);
        _titleLbl.font = kSysFont(18);
        _titleLbl.text = @"售卖状态";
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        [self.frameStateV addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UIButton *)noSellBtn
{
    if (!_noSellBtn) {
        _noSellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_noSellBtn setTitle:@"未售卖" forState:UIControlStateNormal];
        _noSellBtn.tag = 300 + 0;
        [_noSellBtn setSelected:YES];
        _selectBtn = _noSellBtn;
        _defaultBtn = _noSellBtn;
        [_noSellBtn setTitleColor:kMainColor forState:UIControlStateSelected];
        [_noSellBtn setTitleColor:kHexColor(0xFF666666) forState:UIControlStateNormal];
        [self.frameStateV addSubview:_noSellBtn];
    }
    return _noSellBtn;
}

- (UIButton *)selledBtn
{
    if (!_selledBtn) {
        _selledBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selledBtn setTitle:@"已售卖" forState:UIControlStateNormal];
        _selledBtn.tag = 300 + 1;
        [_selledBtn setTitleColor:kMainColor forState:UIControlStateSelected];
        [_selledBtn setTitleColor:kHexColor(0xFF666666) forState:UIControlStateNormal];
        [self.frameStateV addSubview:_selledBtn];
    }
    return _selledBtn;
}

- (RACSubject *)selectBlockSub
{
    if (!_selectBlockSub) {
        _selectBlockSub = [RACSubject subject];
    }
    return _selectBlockSub;
}





@end
