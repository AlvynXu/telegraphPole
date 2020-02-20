//
//  UIView+Loading.m
//  Refactoring
//
//  Created by dingqiankun on 2019/3/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "UIView+Loading.h"
#import <objc/runtime.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <objc/runtime.h>

@interface UIView ()

@property(nonatomic, strong)MBProgressHUD *hud;

@end



@implementation UIView (Loading)

@dynamic emptyView;

static const void *private_hudkey = &private_hudkey;
static const void *private_emptykey = &private_emptykey;

- (void)showLoading
{
    if (self.hud) {
        [self hideLoading];
        [self createHud:NO];
    } else {
        [self createHud:NO];
    }
    self.hud.customView = [self createCustomView];
}

- (void)showPageLoading
{
    if (self.hud) {
        [self hideLoading];
        [self createHud:YES];
    } else {
        [self createHud:YES];
    }
    self.hud.customView = [self createCustomView];
}

- (void)showLoadigWith:(NSString *)message
{
    if (self.hud) {
        [self hideLoading];
        [self createHud:NO];
    } else{
        [self createHud:NO];
    }
    self.hud.label.text = message?:@"加载中...";
    self.hud.customView = [self createCustomView];
}

- (void)hideLoading
{
    if (self.hud) {
        [self.hud removeFromSuperViewOnHide];
//        self.hud.backgroundColor = kHexColorA(0xffffff, 1);
        [UIView animateWithDuration:0.5 animations:^{
//            self.hud.backgroundColor = self.backgroundColor;
            [self.hud hideAnimated:YES];
        }];
        
        objc_setAssociatedObject(self, private_hudkey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)hideLoadingWithRequest:(XMBaseRequest *)request rect:(CGRect)rect
{
    [self hideLoading];
    [self createEmptyView:rect];
    [self _hideLoadingWithRequest:request];
}


- (void)hideLoadingWithRequest:(XMBaseRequest *)request
{
    [self hideLoading];
    [self createEmptyView:CGRectZero];
//    [self _hideLoadingWithRequest:request];
    [self _newHideLogingWithRequest:request];
}

#pragma mark  ----  私有方法

- (void)_newHideLogingWithRequest:(XMBaseRequest *)request
{
    BOOL isHasNextPage = YES;
    if ([request isKindOfClass:[XMBasePageRequest class]]) {  // 分页请求
        XMBasePageRequest *pageRequest = (XMBasePageRequest *)request;
        if (request.error) {  // 首先判断服务器错误
            [XMHUD showError:request.error];
            // 服务器出错 页面又无数据情况下 加载服务器连接失败的空视图
            if (!pageRequest.businessModelArray.count) {
                [self setViewErrorSateWith:pageRequest.error];
            }else{
                // 服务器出错 页面有数据情况下。只弹窗提示报错
            }
        }else{
            isHasNextPage = pageRequest.hasNextPage;// 判断是否有下一页
            // 如果当前页面无数据 加载无数据空视图
            if (!pageRequest.businessModelArray.count) {
                [self.emptyView showWith:EmptySateEmptyData];
            }else{
                // 页面有数据加载 移除空视图
                [self.emptyView setStateWithNormal];
            }
        }
    }else{  //不是分页请求
        if (request.error) {
            [self setViewErrorSateWith:request.error];
        }else{
            // 正常状态下
            [self.emptyView setStateWithNormal];
        }
    }
    
    // 统一判断  当前页面是否是列表数据
    if ([self isKindOfClass:UIScrollView.class]) {
        [((UIScrollView *)self) headerEndRefreshing];
        
        if (isHasNextPage) {
            [((UIScrollView *)self).mj_footer endRefreshing];
        }else{
            if ([request isKindOfClass:XMBasePageRequest.class]) {
                XMBasePageRequest *pageRequest = (XMBasePageRequest *)request;
                // 判断要不要显示 没有更多数据 提示
                if (pageRequest.businessModelArray.count == 0) {
                    [((UIScrollView *)self) endRefreshingNoMoreDataNoTips];
                }else{
                    [((UIScrollView *)self) endRefreshingNoMoreDataWithTip:nil];
                }
            }else{
                [((UIScrollView *)self) endRefreshingNoMoreDataNoTips];
            }
            
        }
        
        if ([self isKindOfClass:UITableView.class]) {
            [((UITableView *)self) reloadData];
        }
        if ([self isKindOfClass:UICollectionView.class]) {
            [((UICollectionView *)self) reloadData];
        }
    }
}


- (void)_hideLoadingWithRequest:(XMBaseRequest *)request
{
    BOOL isHasNextPage = YES;
    if ([request isKindOfClass:[XMBasePageRequest class]]) { // 分页请求
        XMBasePageRequest *pageRequest = (XMBasePageRequest *)request;
        if (request.responseObject) {
            // 网络正常
            isHasNextPage = pageRequest.hasNextPage;
            if (!pageRequest.businessModelArray.count) {  // 有网络 没有数据
                [self.emptyView showWith:EmptySateEmptyData];
            }else {
                // 正常有数据情况下 移除空视图
                [self.emptyView setStateWithNormal];
            }
        }else{
            /**
             服务器数据 返回不存在，b出错的情况下，判断当前页面之前是否已有数据，r如果已有数据 就不需加载错误视图，只需弹窗提示。
             如果没有数据加载错误视图
             */
            [XMHUD showError:request.error];
            if (request.error && !pageRequest.businessModelArray.count) {  // 无网络情况下，判断数组长度是否为0
                [self setViewErrorSateWith:pageRequest.error];
            } else if (request.error) {
            }
        }
        
    }else{
        // 当前请求不是分页请求
        if (request.responseObject) {
            // 正常状态下
            [self.emptyView setStateWithNormal];
        }else {
            if (request.error) {
                // 有错误提示
                [self setViewErrorSateWith:request.error];
            }
        }
        
    }
    
    if ([self isKindOfClass:UIScrollView.class]) {
        [((UIScrollView *)self) headerEndRefreshing];
        
        if (isHasNextPage) {
            [((UIScrollView *)self).mj_footer endRefreshing];
        }else{
            if ([request isKindOfClass:XMBasePageRequest.class]) {
                XMBasePageRequest *pageRequest = (XMBasePageRequest *)request;
                // 判断要不要显示 没有更多数据 提示
                if (pageRequest.businessModelArray.count == 0) {
                    [((UIScrollView *)self) endRefreshingNoMoreDataNoTips];
                }else{
                    [((UIScrollView *)self) endRefreshingNoMoreDataWithTip:nil];
                }
            }else{
                  [((UIScrollView *)self) endRefreshingNoMoreDataNoTips];
            }
            
        }
        
        if ([self isKindOfClass:UITableView.class]) {
            [((UITableView *)self) reloadData];
        }
        if ([self isKindOfClass:UICollectionView.class]) {
            [((UICollectionView *)self) reloadData];
        }
    }
}

- (void)hideLoadingAndEndRefreshNoTipsEmpty:(XMBaseRequest *)request
{
    if ([self isKindOfClass:UIScrollView.class]) {
        [((UIScrollView *)self) headerEndRefreshing];
        if ([request isKindOfClass:XMBasePageRequest.class]) {
           BOOL isHasNextPage = YES;
            XMBasePageRequest *pageRequest = (XMBasePageRequest *)request;
             isHasNextPage = pageRequest.hasNextPage;
            // 判断要不要显示 没有更多数据 提示
            if (isHasNextPage) {
                [((UIScrollView *)self) footerEndRefreshing];
            }else{
                if (pageRequest.businessModelArray.count == 0) {
                    [((UIScrollView *)self) endRefreshingNoMoreDataNoTips];
                }else{
                    [((UIScrollView *)self) endRefreshingNoMoreDataWithTip:nil];
                }
            }
        }
        if ([self isKindOfClass:UITableView.class]) {
            [((UITableView *)self) reloadData];
        }
        if ([self isKindOfClass:UICollectionView.class]) {
            [((UICollectionView *)self) reloadData];
        }
    }
}


- (void)setViewErrorSateWith:(NSError *)error
{
    [XMHUD showError:error];
    if (error.code == -1009 || error.code == -1004) {
        // 1.无网络
//        [self.emptyView setDetail:error.localizedDescription forState:EmptySateNetWoXMError];
        [self.emptyView showWith:EmptySateNetWorkError];
        
    } else {
        // 服务器出问题
//        [self.emptyView setDetail:error.localizedDescription forState:EmptySateServerError];
        [self.emptyView showWith:EmptySateServerError];
        
    }
}

// 创建自定义视图
- (UIView *)createCustomView
{
    UIImageView *imageV = [[UIImageView alloc] initWithImage:kGetImage(@"loading-hud")];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.toValue = @(M_PI * 2);
    animation.duration = 1.f;
    animation.repeatCount = MAXFLOAT;
     [imageV.layer addAnimation:animation forKey:@"rotationAnimation"];
    return imageV;
}

- (void)createHud:(BOOL)page
{
    self.hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    self.hud.bezelView.backgroundColor = [UIColor clearColor];
    if (page) {
        self.hud.backgroundView.backgroundColor = [self getBackgoundColorWith:self];
    }else{
        self.hud.backgroundView.backgroundColor = [UIColor clearColor];
    }
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.label.font = kSysFont(10);
    self.hud.label.textColor = kMainColor;
}

- (void)createEmptyView:(CGRect)rect
{
    
    if (!self.emptyView) {
        if (rect.size.width>0) {
            self.emptyView = [[XMEmptyView alloc] initWithFrame:rect];
        }else{
            if (self.bounds.size.width == kScreenWidth && self.bounds.size.height > kScreenHeight / 2) { // 特殊情况
                self.emptyView = [[XMEmptyView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            }else {
                self.emptyView = [[XMEmptyView alloc] initWithFrame:self.bounds];
            }
        }
        self.emptyView.backgroundColor = [self getBackgoundColorWith:self];
    }
    if (!self.emptyView.superview) {
//        if ([self isKindOfClass:UIScrollView.class]) {
//            [self.superview addSubview:self.emptyView];
//            [self.superview bringSubviewToFront:self.emptyView];
//        }else {
            [self addSubview:self.emptyView];
            [self bringSubviewToFront:self.emptyView];
//        }
    }
}

- (UIColor *)getBackgoundColorWith:(UIView *)view
{
    UIColor *color;
    if (CGColorEqualToColor(view.backgroundColor.CGColor, [UIColor clearColor].CGColor)) {
        view = self.superview;
        color = [self getBackgoundColorWith:view];
    }else {
        color = self.superview.backgroundColor;
    }
    return color;
}
- (MBProgressHUD *)hud
{
    return objc_getAssociatedObject(self, private_hudkey);
}

- (void)setHud:(MBProgressHUD *)hud
{
    if (!self.hud) {
        objc_setAssociatedObject(self, private_hudkey, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setEmptyView:(XMEmptyView *)emptyView
{
    if (!self.emptyView) {
        objc_setAssociatedObject(self, private_emptykey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (XMEmptyView *)emptyView
{
    return objc_getAssociatedObject(self, private_emptykey);
}


#pragma maXM ---  懒加载


@end
