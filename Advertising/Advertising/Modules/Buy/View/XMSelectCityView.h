//
//  XMSelectCityView.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XMLevel) {
    XMLevelFour  = 4,
    XMLevelThree = 3,
    XMLevelTwo = 2
};

@interface XMSelectCityView : UIView

@property(nonatomic, strong)NSMutableArray *parentArray;

@property(nonatomic, strong)NSMutableArray *cityArray;

@property(nonatomic, strong)NSMutableArray *countArray;

@property(nonatomic, strong)NSMutableArray *streetArray;

@property(nonatomic, strong)UIPickerView *pickerV;

@property(nonatomic, strong)RACSubject *subject;

@property(nonatomic, assign)XMLevel level;

//@property(nonatomic, assign)BOOL isLandlord;  // 判断是否是地主  地主 3级， 展位4级

@property(nonatomic, assign)BOOL isDefaultCity;  // 选中省后默认z选择第一个市


- (void)show;

- (void)hinde;

@end

NS_ASSUME_NONNULL_END
