//
//  XMSelectCanStreetView.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/2.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMSelectCanStreetView.h"
#import "XMSelectCanStreetCell.h"

@interface XMSelectCanStreetView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UIView *baseV;

@property(nonatomic, strong)UIView *contentV;

@property(nonatomic, strong)UIImageView *iconImgV;  // icon

@property(nonatomic, strong)UIButton *cancelBtn;  // 取消

@property(nonatomic, strong)UILabel *tipsLbl;  // 提示

@property(nonatomic, strong)UITableView *tableView;  // 表视图

@property(nonatomic, strong)UILabel *sallMoenyTipsLbl;  // 出租金额

@property(nonatomic, strong)UILabel *moneySymbolLbl;  // 金额符号

@property(nonatomic, strong)UILabel *sallMoneyNumLbl;  // 出租金额

@property(nonatomic, strong)UIButton *sureBtn;  // 确认

@property(nonatomic, strong)NSMutableArray *selectArray;

@end

@implementation XMSelectCanStreetView

CGFloat rentContentHeight = 392;

static NSString *selectCanStreetCell = @"XMSelectCanStreetCell_cellId";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self addClickEvent];
    }
    return self;
}

// 初始化
- (void)setup
{
    [self.baseV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.safeEqualToBottom(self);
    }];
    
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(rentContentHeight));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(rentContentHeight);
    }];
    
    UIView *baseBootomV = [UIView new];
    baseBootomV.backgroundColor = UIColor.whiteColor;
    [self.contentV addSubview:baseBootomV];
    [baseBootomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentV);
        make.height.equalTo(@20);
    }];

    
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16.5);
        make.top.equalTo(@19);
        make.height.equalTo(@15.5);
        make.width.equalTo(@12.5);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@25.5);
        make.centerY.equalTo(self.iconImgV);
        make.right.equalTo(self.mas_right).offset(-16.5);
    }];
    
    [self.tipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImgV);
        make.left.equalTo(self.iconImgV.mas_right).offset(9);
        make.height.equalTo(@11.5);
    }];
    
    [self.sallMoenyTipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.bottom.equalTo(self.contentV.mas_bottom).offset(-17.5);
        make.width.equalTo(@55);
        make.height.equalTo(@13);
    }];
    
    [self.moneySymbolLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sallMoenyTipsLbl.mas_right).offset(2);
        make.bottom.equalTo(self.sallMoneyNumLbl);
        make.height.equalTo(@13);
        make.width.equalTo(@15);
    }];
    
    [self.sallMoneyNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneySymbolLbl.mas_right).offset(0);
        make.bottom.equalTo(self.sallMoenyTipsLbl);
        make.height.equalTo(@22);
        make.right.equalTo(self.sureBtn.mas_left).offset(-10);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-17);
        make.bottom.equalTo(self.sallMoenyTipsLbl.mas_bottom).offset(10);
        make.width.equalTo(@140);
        make.height.equalTo(@45);
    }];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[XMSelectCanStreetCell class] forCellReuseIdentifier:selectCanStreetCell];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.tipsLbl.mas_bottom).offset(28);
        make.bottom.equalTo(self.sureBtn.mas_top).offset(-15);
    }];
}

// 添加单击事件
- (void)addClickEvent
{
    @weakify(self)
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if ([self getSelectStreet].count == 0) {
            [XMHUD showText:@"请先选择街道"];
            return ;
        }
        // 获取选择的展位ID
        [self.sureBuySubject sendNext:@{@"orderId":@(self.orderId), @"areaCode":[self getSelectStreet]}];
    }];
    
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self hinde];
    }];
}

#pragma mark  --------  UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMSelectCanStreetCell *cell = [tableView dequeueReusableCellWithIdentifier:selectCanStreetCell forIndexPath:indexPath];
    
    XMRentCanStreetItemModel *itemModel = self.dataSource[indexPath.row];
    cell.itemModel = itemModel;
    
    [cell.selectBtn addTarget:self action:@selector(handSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectBtn.tag = kButton_tag + indexPath.row;
    [cell.selectBtn setSelected:itemModel.isSelect];
    return cell;
}

// 选择
- (void)handSelectAction:(UIButton *)sender
{
    NSInteger row = sender.tag - kButton_tag;
    [sender setSelected:!sender.isSelected];
    XMRentCanStreetItemModel *itemModel =  self.dataSource[row];
    itemModel.isSelect = sender.isSelected;
    CGFloat totalPrice = [self caculeMoney];
    self.sallMoneyNumLbl.text = kFormat(@"%.2lf", totalPrice);
}


// 计算金额
-(CGFloat)caculeMoney
{
    CGFloat totalPrice = 0;
    NSMutableArray *orderIdArray = [NSMutableArray array];
    for (XMRentCanStreetItemModel *itemModel in self.dataSource) {
        if (itemModel.isSelect) {
            totalPrice = totalPrice + (itemModel.price *self.day);
            [orderIdArray addObject:itemModel.streetCode];
        }
    }
    return totalPrice;
}

- (NSArray *)getSelectStreet
{
    NSMutableArray *orderIdArray = [NSMutableArray array];
    for (XMRentCanStreetItemModel *itemModel in self.dataSource) {
        if (itemModel.isSelect) {
            [orderIdArray addObject:itemModel.streetCode];
        }
    }
    return orderIdArray;
}

#pragma mark  -----  加载数据
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    
    [self.tableView reloadData];
}

#pragma mark  ----- 单击事件
- (void)show
{
    if (!self.superview) {
        [kWindow addSubview:self];
    }
    self.baseV.hidden = NO;
    [self.contentV.superview layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.safeEqualToBottom(self);
        }];
        [self.contentV.superview layoutIfNeeded];//强制绘制
    }];
    
    CGFloat totalPrice = [self caculeMoney];
    self.sallMoneyNumLbl.text = kFormat(@"%.2lf", totalPrice);
}

- (void)hinde
{
    [self.baseV.superview layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(rentContentHeight);
        }];
        [self.contentV.superview layoutIfNeeded];//强制绘制
    } completion:^(BOOL finished) {
        self.baseV.hidden = YES;
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
}

- (void)setCount:(NSInteger)count
{
    _count = count;
    self.tipsLbl.text = kFormat(@"区域内您有 %zd 个%@", count, kApp_Name);
    [self.tipsLbl changeStr:kFormat(@"%zd", count) color:kHexColor(0xFFF85F53) font:kSysFont(12)];
}


#pragma mark  --------- 圆角剪切
-(void)changeViewStyle:(UIView *)view{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(7, 7)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate  =self;
        _tableView.dataSource = self;
        [self.contentV addSubview:_tableView];
    }
    return _tableView;
}

- (UIImageView *)iconImgV
{
    if (!_iconImgV) {
        _iconImgV = [UIImageView new];
        _iconImgV.image = kGetImage(@"rent_local_icon");
        [self.contentV addSubview:_iconImgV];
    }
    return _iconImgV;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setImage:kGetImage(@"rent_cancel_icon") forState:UIControlStateNormal];
        [self.contentV addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (UILabel *)tipsLbl
{
    if (!_tipsLbl) {
        _tipsLbl = [UILabel new];
        _tipsLbl.textColor = kHexColor(0xFF333333);
        _tipsLbl.font = kSysFont(12);
        [self.contentV addSubview:_tipsLbl];
    }
    return _tipsLbl;
}

- (UILabel *)sallMoenyTipsLbl
{
    if (!_sallMoenyTipsLbl) {
        _sallMoenyTipsLbl = [UILabel new];
        _sallMoenyTipsLbl.text = @"出租金额:";
        _sallMoenyTipsLbl.font = kSysFont(12);
        _sallMoenyTipsLbl.textColor = kHexColor(0xFF333333);
        [self.contentV addSubview:_sallMoenyTipsLbl];
    }
    return _sallMoenyTipsLbl;
}

- (UILabel *)moneySymbolLbl
{
    if (!_moneySymbolLbl) {
        _moneySymbolLbl = [UILabel new];
        _moneySymbolLbl.text = @"￥";
        _moneySymbolLbl.font = kSysFont(12);
        _moneySymbolLbl.textColor = kHexColor(0xFFF85F53);
        [self addSubview:_moneySymbolLbl];
    }
    return _moneySymbolLbl;
}

- (UILabel *)sallMoneyNumLbl
{
    if (!_sallMoneyNumLbl) {
        _sallMoneyNumLbl = [UILabel new];
        _sallMoneyNumLbl.textColor = kHexColor(0xFFF85F53);
        _sallMoneyNumLbl.font = kSysFont(22);
        _sallMoneyNumLbl.adjustsFontSizeToFitWidth = YES;
        _sallMoneyNumLbl.minimumScaleFactor = 0.3;
        [self.contentV addSubview:_sallMoneyNumLbl];
    }
    return _sallMoneyNumLbl;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.backgroundColor = kMainColor;
        _sureBtn.layer.cornerRadius = 7;
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.titleLabel.font = kSysFont(16);
        [_sureBtn setTitle:@"确认出租" forState:UIControlStateNormal];
        [self.contentV addSubview:_sureBtn];
    }
    return _sureBtn;
}


- (UIView *)baseV
{
    if (!_baseV) {
        _baseV = [UIView new];
        _baseV.backgroundColor = kHexColorA(0x000000, 0.7);
        [self addSubview:_baseV];
    }
    return _baseV;
}

- (UIView *)contentV
{
    if (!_contentV) {
        _contentV = [UIView new];
        _contentV.backgroundColor = UIColor.whiteColor;
        _contentV.layer.cornerRadius = 20;
        [self.baseV addSubview:_contentV];
    }
    return _contentV;
}

- (RACSubject *)sureBuySubject
{
    if (!_sureBuySubject) {
        _sureBuySubject = [RACSubject subject];
    }
    return _sureBuySubject;
}



@end
