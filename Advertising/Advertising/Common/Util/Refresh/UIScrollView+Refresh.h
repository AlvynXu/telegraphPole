//
//  UIScrollView+Refresh.h

#import <UIKit/UIKit.h>
#import "XMDIYHeader.h"
#import "XMDIYAutoFooter.h"
#import <MJRefresh/MJRefresh.h>


@interface UIScrollView (Refresh)

#pragma mark -头部下拉刷新

///添加下拉刷新控件（块回调）
- (void)addHeaderWithCallback:(MJRefreshComponentRefreshingBlock)refreshingBlock;

///添加下拉刷新头部控件（selector回调）
- (void)addHeaderWithTarget:(id)target action:(SEL)action;

///移除头部下拉刷新
- (void)removeHeader;

///头部下拉刷新主动进入刷新状态
- (void)headerBeginRefreshing;

///头部下拉刷新停止刷新状态
- (void)headerEndRefreshing;

///下拉刷新头部控件的可见性
@property (nonatomic, assign, getter = isHeaderHidden) BOOL headerHidden;

///是否正在下拉刷新
@property (nonatomic, assign, readonly, getter = isHeaderRefreshing) BOOL headerRefreshing;

#pragma mark -底部上拉刷新

///添加底部上拉刷新控件（块回调）
- (void)addFooterWithCallback:(MJRefreshComponentRefreshingBlock)refreshingBlock;

///添加底部上拉刷新控件（selector回调）
- (void)addFooterWithTarget:(id)target action:(SEL)action;

///移除底部上拉刷新
- (void)removeFooter;

///主动让上拉刷新尾部控件进入刷新状态
- (void)footerBeginRefreshing;

///让上拉刷新尾部控件停止刷新状态
- (void)footerEndRefreshing;
//传空值时使用默认提示
- (void)endRefreshingHasMoreData:(BOOL)hasMoreData tip:(NSString*)tip;
- (void)endRefreshingNoMoreDataWithTip:(NSString*)tip;

// 不提示
- (void)endRefreshingNoMoreDataNoTips;

///上拉刷新头部控件的可见性
@property (nonatomic, assign, getter = isFooterHidden) BOOL footerHidden;

/// 是否正在上拉刷新
@property (nonatomic, assign, readonly, getter = isFooterRefreshing) BOOL footerRefreshing;

@end
