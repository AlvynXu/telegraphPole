//
//  XMSelectStreetView.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/7.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMSelectStreetView.h"
#import "XMSelectStreetCell.h"
#import "XMAreaSelectRequest.h"

@interface XMSelectStreetView()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)XMStreetRequest *streetRequest;

@end

static NSString *const selectStreetCell_identifer = @"XMSelectStreetCell_Id";

@implementation XMSelectStreetView

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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.left.right.equalTo(self);
    }];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[XMSelectStreetCell class] forCellReuseIdentifier:selectStreetCell_identifer];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)setItemModel:(XMAreaItemModel *)itemModel
{
    _itemModel = itemModel;
    self.streetRequest.code = itemModel.code;
    [self.streetRequest startWithCompletion:^(__kindof XMStreetRequest * _Nonnull request, NSError * _Nonnull error) {
        if (request.businessSuccess) {
           XMStreetModel *streetModel = request.businessModel;
            self.dataSource = streetModel.data;
        }
        [self.tableView reloadData];
    }];
}

#pragma mark -------- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMSelectStreetCell *selectStreetCell = [tableView dequeueReusableCellWithIdentifier:selectStreetCell_identifer forIndexPath:indexPath];
    XMStreetItemModel *itemModel = self.dataSource[indexPath.section];
    selectStreetCell.selectBtn.tag = kButton_tag + indexPath.section;
    [selectStreetCell.selectBtn addTarget:self action:@selector(handSeletAction:) forControlEvents:UIControlEventTouchUpInside];
    // 全选
    selectStreetCell.streetItemModel = itemModel;
    return selectStreetCell;
}

- (void)handSeletAction:(UIButton *)sender
{
    NSInteger index = sender.tag - kButton_tag;
    XMStreetItemModel *itemModel = self.dataSource[index];
    [sender setSelected:!sender.isSelected];
    itemModel.select = sender.isSelected;
    [self.tableView reloadData];
    [self currentArearSelect];
    [self.subject sendNext:@""];
}
// 全选
- (void)allReloadSelct
{
    [self _allSelect];
}

- (void)cancelAllSelect
{
    [self _allCancelSelect];
}

// 全部选择
- (void)_allSelect
{
    for (XMStreetItemModel *itemModel in self.dataSource) {
        itemModel.select = YES;
    }
    [self.tableView reloadData];
}

// 取消全选
- (void)_allCancelSelect
{
    for (XMStreetItemModel *itemModel in self.dataSource) {
        itemModel.select = NO;
    }
    [self.tableView reloadData];
}


- (void)currentArearSelect
{
    BOOL cancelAllSelect = NO;
    for (XMStreetItemModel *itemModel in self.dataSource) {
        if (!itemModel.select) {
            cancelAllSelect = YES;
            break;
        }
    }
    self.cancelSelect = cancelAllSelect;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.whiteColor;
        [self addSubview:_tableView];
    }
    return _tableView;
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
