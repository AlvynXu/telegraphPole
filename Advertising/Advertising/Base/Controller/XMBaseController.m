//
//  GXBaseController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseController.h"

#ifdef DEBUG
//#import "MLeaksFinder.h"
#else

#endif



@interface XMBaseController ()

@end

@implementation XMBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


- (void)setupUI
{
    self.view.backgroundColor = kMainBackGroundColor;
    
//    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
}


@end
