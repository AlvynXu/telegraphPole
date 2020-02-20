//
//  RKTestController.m
//  Refactoring
//
//  Created by dingqiankun on 2019/4/1.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMTestController.h"
#import "XMTestVM.h"
#import "XMTestCell.h"
#import "XMDataModel.h"
#import "XMMoreDisorderlyRequestController.h"

@interface XMTestController ()

@property(nonatomic, strong)XMTestVM *testVM;

@property(nonatomic, strong)NSArray *dataSource;

@end

@implementation XMTestController

static NSString *cellIdentifer = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.redColor;
    
     NSLog(@"======------------   1111  ");
    
    UILabel *la = [UILabel new];
    la.frame = CGRectMake(100, 200, 100, 30);
    la.text = @"我是温控";
    [self.view addSubview:la];
    
    
//    [self createView];
//    [self setup];
//    [self.tableView showPageLoading];
////    [self requestBlockWithCmd];
//    [self requestBlock];
    
}

// 视图
- (void)createView
{
    [self.tableView registerClass:[XMTestCell class] forCellReuseIdentifier:cellIdentifer];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.safeEqualToTop(self.view);
        make.bottom.equalTo(self.view);
    }];
}

// 初始化
- (void)setup
{
    @weakify(self)
    [self.tableView addHeaderWithCallback:^{
        @strongify(self)
        self.testVM.testRequest.needRefresh = YES;
        // 信号
        [self.testVM.loadDataCmd execute:@"刷新"];
        //普通
//        [self requestBlock];
    }];
    
    [self.tableView addFooterWithCallback:^{
        @strongify(self)
        self.testVM.testRequest.needRefresh = NO;
        // 信号
//        [self.testVM.loadDataCmd execute:@"加载更多"];
        // 普通
        [self requestBlock];
    }];
}


// 普通请求
- (void)requestBlock
{
    /**
       思想：网络请求主要是以面向对象的思想，摒弃之前的字典key-value
       1.testRequest: 网络请求类, 建议去看看BaseRequest、以及BasePageRequest
       2.request.businessModelArray  服务器响应的数据
     */
    
    @weakify(self)
    [self.testVM.testRequest startWithCompletion:^(__kindof XMTestRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        self.dataSource = request.businessModelArray;
        [self.tableView hideLoadingWithRequest:request];
    }];
}

// 使用信号发送请求
- (void)requestBlockWithCmd
{
    @weakify(self)
    [self.testVM.loadDataCmd.executionSignals.switchToLatest subscribeNext:^(XMBasePageRequest *request) {
        @strongify(self)
        self.dataSource = request.businessModelArray;
        [self.tableView hideLoadingWithRequest:request];
    }];
    [self.testVM.loadDataCmd execute:@"刷新"];
}

#pragma mark   ---- tableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMTestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    XMDataModel *dataModel = self.dataSource[indexPath.row];
    [cell setViewWithModel:dataModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"++++++++++===");
    [self.navigationController pushViewController:[XMMoreDisorderlyRequestController new] animated:YES];
}

#pragma mark  ------  懒加载

- (XMTestVM *)testVM
{
    if (!_testVM) {
        _testVM = [[XMTestVM alloc] init];
    }
    return _testVM;
}




@end
