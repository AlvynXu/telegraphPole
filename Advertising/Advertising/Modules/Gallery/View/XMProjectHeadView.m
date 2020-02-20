//
//  XMProjectHeadView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMProjectHeadView.h"
#import "UIButton+ImageTitleSpacing.h"

@interface XMProjectHeadView()

@property(nonatomic, strong)UILabel *titleLbl;  // 标题

@property(nonatomic, strong)UIImageView *viewsImgV;  // 浏览

@property(nonatomic, strong)UILabel *viewsLbl;  // 浏览

@property(nonatomic, strong)UIImageView *shareImgV;  //分享

@property(nonatomic, strong)UILabel *shareLbl;  // 分享

@property(nonatomic, strong)UILabel *addressTipsLbl;  // 地址提示

@property(nonatomic, strong)UILabel *addressLbl; // 联系地址

@property(nonatomic, strong)UILabel *phoneLbl;  // 联系方式

@end

@implementation XMProjectHeadView

CGFloat titleTop = 20;
CGFloat viewsImgVTop = 22;
CGFloat viewsLblHeight = 25;
CGFloat line1Top = 10;
CGFloat line1Height = 7;
CGFloat addressLblTop = 10;
CGFloat addressLblHeight = 20;
CGFloat phoneLblTop = 10;
CGFloat phoneLblHeight = 25;
CGFloat line2Top = 10;
CGFloat line2Height = 7;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(@(titleTop));
    }];
    
    [self.viewsImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl);
        make.width.equalTo(@18);
        make.height.equalTo(@12);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(viewsImgVTop);
    }];
    
    [self.viewsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewsImgV.mas_right).offset(6);
        make.centerY.equalTo(self.viewsImgV);
        make.height.equalTo(@(viewsLblHeight));
    }];
    
    [self.shareImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewsLbl.mas_right).offset(30);
        make.centerY.equalTo(self.viewsLbl);
        make.height.equalTo(@17);
        make.width.equalTo(@18);
    }];
    
    // 举报功能暂不开放
    
    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shareImgV);
        make.width.equalTo(@100);
        make.height.equalTo(@35);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    [self.reportBtn setImage:kGetImage(@"project_report_icon") forState:UIControlStateNormal];
    self.reportBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.reportBtn setTitleColor:kHexColor(0xFF666666) forState:UIControlStateNormal];
    self.reportBtn.titleLabel.font = kSysFont(14);
    [self.reportBtn setTitle:@"举报" forState:UIControlStateNormal];
    [self.reportBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:1];
    self.reportBtn.hidden = YES;
    
    
    [self.shareLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shareImgV.mas_right).offset(6);
        make.centerY.equalTo(self.shareImgV);
        make.height.equalTo(self.viewsLbl.mas_height);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = kHexColor(0xf4f4f4);
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.shareLbl.mas_bottom).offset(line1Top);
        make.height.equalTo(@(line1Height));
    }];
    
    [self.phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLbl);
        make.top.equalTo(line1.mas_bottom).offset(phoneLblTop);
        make.height.equalTo(@(addressLblHeight));
    }];
    
    [self.addressTipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.phoneLbl);
        make.centerY.equalTo(self.addressLbl);
        make.width.equalTo(@75);
    }];
    
    [self.addressLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressTipsLbl.mas_right);
        make.right.equalTo(self.phoneLbl);
        make.top.equalTo(self.phoneLbl.mas_bottom).offset(addressLblTop);
    }];
    
    
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = kHexColor(0xf4f4f4);
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.addressLbl.mas_bottom).offset(line2Top);
        make.height.equalTo(@(line2Height));
//        make.bottom.equalTo(self);
    }];
}

- (void)setDetailModel:(XMProjectDetailModel *)detailModel
{
    _detailModel = detailModel;
    self.titleLbl.text = detailModel.desc;
    self.viewsLbl.text = kFormat(@"%zd", detailModel.views);
    self.shareLbl.text = kFormat(@"%zd", detailModel.shareCount);
    self.phoneLbl.text = kFormat(@"电话/微信: %@", detailModel.phone);
    self.addressLbl.text = kFormat(@"%@", detailModel.addressDetail);
}


// 总视图高度
- (CGFloat)totalHeight
{
    CGFloat height = titleTop+viewsImgVTop+viewsLblHeight+line1Top+line1Height+addressLblTop+phoneLblTop+phoneLblHeight+line2Top+line2Height;
    return height;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.numberOfLines = 0;
        _titleLbl.font = kBoldFont(18);
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UIImageView *)viewsImgV
{
    if (!_viewsImgV) {
        _viewsImgV = [UIImageView new];
        _viewsImgV.image = kGetImage(@"project_views");
        [self addSubview:_viewsImgV];
    }
    return _viewsImgV;
}

- (UILabel *)viewsLbl
{
    if (!_viewsLbl) {
        _viewsLbl = [UILabel new];
        [self addSubview:_viewsLbl];
    }
    return _viewsLbl;
}

- (UIImageView *)shareImgV
{
    if (!_shareImgV) {
        _shareImgV = [UIImageView new];
        _shareImgV.image = kGetImage(@"project_share");
        [self addSubview:_shareImgV];
    }
    return _shareImgV;
}

- (UILabel *)shareLbl
{
    if (!_shareLbl) {
        _shareLbl = [UILabel new];
        [self addSubview:_shareLbl];
    }
    return _shareLbl;
}

- (UILabel *)addressLbl
{
    if (!_addressLbl) {
        _addressLbl = [UILabel new];
        _addressLbl.textColor = kHexColor(0x101010);
        _addressLbl.font = kSysFont(14);
        _addressLbl.numberOfLines = 0;
        [self addSubview:_addressLbl];
    }
    return _addressLbl;
}

- (UILabel *)phoneLbl
{
    if (!_phoneLbl) {
        _phoneLbl = [UILabel new];
        _phoneLbl.textColor = kHexColor(0x101010);
        _phoneLbl.font = kSysFont(14);
        _phoneLbl.text = @"电话/微信";
        [self addSubview:_phoneLbl];
    }
    return _phoneLbl;
}

- (UILabel *)addressTipsLbl
{
    if (!_addressTipsLbl) {
        _addressTipsLbl = [UILabel new];
        _addressTipsLbl.textColor = kHexColor(0x101010);
        _addressTipsLbl.font = kSysFont(14);
        _addressTipsLbl.text = @"联系地址：";
        [self addSubview:_addressTipsLbl];
    }
    return _addressTipsLbl;
}

- (UIButton *)reportBtn
{
    if (!_reportBtn) {
        _reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_reportBtn];
    }
    return _reportBtn;
}


@end
