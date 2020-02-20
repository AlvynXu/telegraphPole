//
//  XMAllAreaaCell.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/7.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMAllAreaaCell.h"
#import "UILabel+Normal.h"

@interface XMAllAreaaCell ()



@end

@implementation XMAllAreaaCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 17.5;
        self.layer.borderColor = kHexColor(0x999999).CGColor;
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setItemModel:(XMAreaItemModel *)itemModel
{
    _itemModel = itemModel;
    self.titleLbl.text = itemModel.name;
    if (itemModel.select) {
        self.layer.borderColor = kMainColor.CGColor;
        self.titleLbl.textColor = kHexColor(0x363636);
    }else{
        self.titleLbl.textColor = kHexColor(0x999999);
        self.layer.borderColor = kHexColor(0x999999).CGColor;
    }
    

}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.font = kSysFont(15);
        _titleLbl.textColor = kHexColor(0x999999);
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}



@end
