//
//  ModeSwitching.h
//  Refactoring
//
//  Created by dingqiankun on 2019/3/21.
//  Copyright © 2019 rongshu. All rights reserved.
//

#ifndef ModeSwitching_h
#define ModeSwitching_h

#ifdef DEBUG

/***************   debug 模式      *******************/



#define kHost @"http://wlgx.test.hiyanjiao.com/"


//#define kHost @"http://192.168.5.4:9000/"


#else

/***************   release 模式      *******************/

#define kHost @"http://wlgx.hiyanjiao.com/"

#endif


#endif /* ModeSwitching_h */
