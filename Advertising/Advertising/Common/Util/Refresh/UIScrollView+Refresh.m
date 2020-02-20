//
//  UIScrollView+Refresh.m
//
//
#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)

///添加下拉刷新控件（块回调）
- (void)addHeaderWithCallback:(MJRefreshComponentRefreshingBlock)refreshingBlock;
{
    self.mj_header = [XMDIYHeader headerWithRefreshingBlock:refreshingBlock];
}

///添加下拉刷新头部控件（selector回调）
- (void)addHeaderWithTarget:(id)target action:(SEL)action;
{
    self.mj_header = [XMDIYHeader headerWithRefreshingTarget:target refreshingAction:action];
}

///移除头部下拉刷新
- (void)removeHeader;
{
    [self.mj_header removeFromSuperview];
    self.mj_header = nil;
}

///头部下拉刷新主动进入刷新状态
- (void)headerBeginRefreshing;
{
    [self.mj_header beginRefreshing];
}

///头部下拉刷新停止刷新状态
- (void)headerEndRefreshing;
{
    [self.mj_header endRefreshing];
}

- (void)setHeaderHidden:(BOOL)hidden
{
    self.mj_header.hidden = hidden;
}

- (BOOL)isHeaderHidden
{
    return self.mj_header.isHidden;
}

- (BOOL)isHeaderRefreshing
{
    return self.mj_header.isRefreshing;
}

#pragma mark -底部上拉刷新

///添加底部上拉刷新控件（块回调）
- (void)addFooterWithCallback:(MJRefreshComponentRefreshingBlock)refreshingBlock;
{
    
    self.mj_footer = [XMDIYAutoFooter footerWithRefreshingBlock:refreshingBlock];
}

///添加底部上拉刷新控件（selector回调）
- (void)addFooterWithTarget:(id)target action:(SEL)action;
{
    self.mj_footer = [XMDIYAutoFooter footerWithRefreshingTarget:target refreshingAction:action];
}

- (void)endRefreshingHasMoreData:(BOOL)hasMoreData tip:(NSString *)tip{
    if (hasMoreData) {
        [self.mj_footer endRefreshing];
    }else{
        [self endRefreshingNoMoreDataWithTip:tip];
    }
}

-(void)endRefreshingNoMoreDataWithTip:(NSString *)tip{
    if(self.contentSize.height<self.frame.size.height) tip =@"";
    [((XMDIYAutoFooter*)self.mj_footer) setTitle:tip?tip:@"没有更多了" forState:MJRefreshStateNoMoreData];
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)endRefreshingNoMoreDataNoTips
{
    [((XMDIYAutoFooter*)self.mj_footer) setTitle:@"" forState:MJRefreshStateNoMoreData];
     [self.mj_footer endRefreshingWithNoMoreData];
}

///移除底部上拉刷新
- (void)removeFooter;
{
    [self.mj_footer removeFromSuperview];
    self.mj_footer = nil;
}

///主动让上拉刷新尾部控件进入刷新状态
- (void)footerBeginRefreshing;
{
    [self.mj_footer beginRefreshing];
}

///让上拉刷新尾部控件停止刷新状态
- (void)footerEndRefreshing;
{
    [self.mj_footer endRefreshing];
}

- (void)setFooterHidden:(BOOL)hidden
{
    self.mj_footer.hidden = hidden;
}

- (BOOL)isFooterHidden
{
    return self.mj_footer.isHidden;
}

- (BOOL)isFooterRefreshing
{
    return self.mj_footer.isRefreshing;
}

@end
