//
//  WSDIYHeader.m
//  wscircle
//
//  Created by 丁乾坤 on 2017/9/4.
//  Copyright © 2017年 杭州云商网络科技有限公司. All rights reserved.
//

#import "XMDIYHeader.h"

@interface XMDIYHeader()

@property (weak, nonatomic) UIActivityIndicatorView *loading;
@property (nonatomic, strong) UILabel *statusLabel;
@property (assign, nonatomic) CGFloat insetTDelta;
@end

@implementation XMDIYHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    // 设置控件的高度
    
    self.mj_h = kIphoneX ?100 : 50;
//    self.mj_w = 320;
    //添加控件
    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.size = CGSizeMake(200, 25);
    statusLabel.font = [UIFont systemFontOfSize:13];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textColor = kHexColor(0x1D2C56);
    [self addSubview:statusLabel];
    self.statusLabel = statusLabel;
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loading.hidesWhenStopped = NO;
    [self addSubview:loading];
    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self);
        make.width.lessThanOrEqualTo(@200);
    }];
    
    [self.loading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.statusLabel.mas_left).offset(-10);
        make.centerY.equalTo(self.statusLabel);
    }];
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    // 在刷新的refreshing状态
    if (self.state == MJRefreshStateRefreshing) {
        // 暂时保留
//        https://github.com/CoderMJLee/MJRefresh/issues/892 注释此句，解决下拉刷新刷新头回不去问题
//        if (self.window == nil) return;
        
        // sectionheader停留解决
        CGFloat insetT = - self.scrollView.mj_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
        insetT = insetT > self.mj_h + _scrollViewOriginalInset.top ? self.mj_h + _scrollViewOriginalInset.top : insetT;
        self.scrollView.mj_insetT = insetT;
        
        self.insetTDelta = _scrollViewOriginalInset.top - insetT;
        return;
    }
    
    // 跳转到下一个控制器时，conjtentInset可能会变
    _scrollViewOriginalInset = self.scrollView.mj_inset;
    
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.mj_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    // >= -> >
    if (offsetY > happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.mj_h;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.mj_h;
    
    if (self.scrollView.isDragging) { // 如果正在拖拽
        self.pullingPercent = pullingPercent;
        if (self.state == MJRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = MJRefreshStatePulling;
        } else if (self.state == MJRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = MJRefreshStateIdle;
        }
    } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            self.statusLabel.text = @"下拉可以刷新";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            self.statusLabel.text = @"松开即可刷新";
            break;
        case MJRefreshStateRefreshing:
             [self.loading startAnimating];
            self.statusLabel.text = @"加载中";
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}




@end
