#import "XMDIYAutoFooter.h"




@implementation XMDIYAutoFooter

//重写prepare
- (void)prepare
{
    [super prepare];
    
    //默认自动刷新
    self.automaticallyRefresh = YES;
    //自定义样式
    [self setTitle:@"" forState:MJRefreshStateIdle];
    [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    
    self.stateLabel.font = [UIFont systemFontOfSize:11];
    self.stateLabel.textColor = kHexColor(0xb3b3b3);
}

@end
