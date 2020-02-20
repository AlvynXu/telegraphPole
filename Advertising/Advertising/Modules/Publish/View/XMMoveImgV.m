//
//  XMMoveImgV.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/15.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMoveImgV.h"

@interface XMMoveImgV ()

@property(nonatomic, strong)UIView *snapshot;

@property(nonatomic, strong)NSIndexPath *sourceIndexPath;

@property(nonatomic, assign)CGPoint location;

@end

@implementation XMMoveImgV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //保存触摸起始点位置
//    self.location = [[touches anyObject] locationInView:self.tableView];
//
//    NSLog(@"******************  %lf   %lf", _location.y, _location.x);
//
////    static UIView *snapshot = nil;
////    static NSIndexPath *sourceIndexPath = nil;
//    if (self.indexPath) {
//        self.sourceIndexPath = self.indexPath;
//        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
//
//        // Take a snapshot of the selected row using helper method.
//        self.snapshot = [self customSnapshoFromView:cell];
//
//        // Add the snapshot as subview, centered at cell's center...
//        __block CGPoint center = cell.center;
//        self.snapshot.center = center;
//        //                snapshot.alpha = 0.0;
//        [self.tableView addSubview:self.snapshot];
//        [UIView animateWithDuration:0.25 animations:^{
//            // Offset for gesture location.
//            center.y = self.location.y;
//            self.snapshot.center = center;
//            //                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
//            //                    snapshot.alpha = 0.98;
//
//            cell.alpha = 0.0f;
//
//        } completion:^(BOOL finished) {
//            cell.hidden = YES;
//        }];
//    }
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//
//    CGPoint point = [[touches anyObject] locationInView:self.tableView];
//    //    float dx = point.x - _startPoint.x;
//
//    NSLog(@"+++++++++++++++++  %lf", point.y);
//
//    CGPoint center = self.snapshot.center;
//    center.y = self.location.y;
//    self.snapshot.center = center;
//    // Is destination valid and is it different from source?
//    if (self.indexPath && ![self.indexPath isEqual:self.sourceIndexPath]) {
//        // ... update data source.
//        // 这里需要注意，我是以section为单位写的
//        [self.dataSource exchangeObjectAtIndex:self.indexPath.section withObjectAtIndex:self.sourceIndexPath.section];
//        // ... move the rows.
//        // 你要看你是拖动section还是拖动row了[]([]())
//        // [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
//        [self.tableView moveSection:self.sourceIndexPath.section toSection:self.indexPath.section];
//        // ... and update source so it is in sync with UI changes.
//        self.sourceIndexPath = self.indexPath;
//    }
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    // Clean up.
//    NSLog(@"************************");
//
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.sourceIndexPath];
//    [UIView animateWithDuration:0.25 animations:^{
//        self.snapshot.center = cell.center;
//        //                snapshot.transform = CGAffineTransformIdentity;
//        //                snapshot.alpha = 0.0;
//        cell.alpha = 1.0f;
//    } completion:^(BOOL finished) {
//        cell.hidden = NO;
//        [self.snapshot removeFromSuperview];
//        self.snapshot = nil;
//        // 显示尾部
////        self.beginMove=NO;
////        [self.tableView reloadData];
//    }];
//    self.sourceIndexPath = nil;
//}

- (UIView *)customSnapshoFromView:(UIView *)inputView
{
    UIView *snapshot = nil;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] < 7.0) {
        //ios7.0 以下通过截图形式保存快照
        snapshot = [self customSnapShortFromViewEx:inputView];
    }else{
        //ios7.0 系统的快照方法
        snapshot = [inputView snapshotViewAfterScreenUpdates:YES];
    }
    
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    return snapshot;
}

- (UIView *)customSnapShortFromViewEx:(UIView *)inputView
{
    CGSize inSize = inputView.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(inSize, NO, [UIScreen mainScreen].scale);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView* snapshot = [[UIImageView alloc] initWithImage:image];
    
    return snapshot;
}



@end
