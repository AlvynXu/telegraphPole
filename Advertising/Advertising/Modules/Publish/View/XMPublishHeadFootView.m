//
//  XMPublishHeadFootView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/15.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMPublishHeadFootView.h"

@interface XMPublishHeadFootView ()

@property(nonatomic, strong)UILabel *txtLbl;

@property(nonatomic, strong)UILabel *movieLbl;

@property(nonatomic, strong)UILabel *imageLbl;


@end

static NSString *const publishHeadFootId = @"publishHeadFootId_headfootId";

@implementation XMPublishHeadFootView

+ (instancetype)headerFooterViewWithTabelView:(UITableView *)tableView
{
    XMPublishHeadFootView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:publishHeadFootId];
    if (headerFooterView == nil) {
        headerFooterView = [[XMPublishHeadFootView alloc]initWithReuseIdentifier:publishHeadFootId];
    }
    return headerFooterView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = kHexColor(0xF7F7F7FF);
        
        [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.txtBtn.mas_left).offset(-50);
            make.height.with.centerY.equalTo(self.txtBtn);
        }];
        
        [self.imageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageBtn.mas_bottom).offset(0);
            make.height.equalTo(@15);
            make.centerX.equalTo(self.imageBtn);
            make.width.equalTo(@60);
        }];
        
        [self.txtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@10);
            make.width.equalTo(@37);
            make.height.equalTo(@35);
            make.centerX.equalTo(self);
        }];
        
        [self.txtLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.txtBtn.mas_bottom).offset(0);
            make.height.equalTo(@15);

            make.centerX.equalTo(self.txtBtn);
            make.width.equalTo(@60);
        }];
        
        [self.movieBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.txtBtn.mas_right).offset(50);
            make.height.with.centerY.equalTo(self.txtBtn);
        }];
        
        [self.movieLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.movieBtn.mas_bottom).offset(0);
            make.height.equalTo(@15);
            make.centerX.equalTo(self.movieBtn);
            make.width.equalTo(@60);
        }];
    }
    
    return self;
    
}

- (UIButton *)txtBtn
{
    if (!_txtBtn) {
        _txtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_txtBtn setImage:kGetImage(@"project_txt_icon") forState:UIControlStateNormal];
        [self addSubview:_txtBtn];
    }
    return _txtBtn;
}

- (UIButton *)imageBtn
{
    if (!_imageBtn) {
        _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imageBtn setImage:kGetImage(@"project_img_icon") forState:UIControlStateNormal];
        [self addSubview:_imageBtn];
    }
    return _imageBtn;
}

- (UIButton *)movieBtn
{
    if (!_movieBtn) {
        _movieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_movieBtn setImage:kGetImage(@"project_movie_icon") forState:UIControlStateNormal];
        
        [self addSubview:_movieBtn];
    }
    return _movieBtn;
}

- (UILabel *)txtLbl
{
    if (!_txtLbl) {
        _txtLbl = [[UILabel alloc] init];
        _txtLbl.text = @"文字";
//        _txtLbl.hidden = YES;
        _txtLbl.font = kSysFont(12);
        _txtLbl.textAlignment = NSTextAlignmentCenter;
        _txtLbl.textColor=kHexColor(0xFF6F6F6F);
        [self addSubview:_txtLbl];
    }
    return _txtLbl;
}

- (UILabel *)movieLbl
{
    if (!_movieLbl) {
        _movieLbl = [UILabel new];
        _movieLbl.text = @"视频";
//        _movieLbl.hidden = YES;
        _movieLbl.textColor=kHexColor(0xFF6F6F6F);
        _movieLbl.font = kSysFont(12);
        _movieLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_movieLbl];
    }
    return _movieLbl;
}

- (UILabel *)imageLbl
{
    if (!_imageLbl) {
        _imageLbl = [UILabel new];
        _imageLbl.text = @"图片";
//        _imageLbl.hidden = YES;
        _imageLbl.textAlignment = NSTextAlignmentCenter;
        _imageLbl.textColor = kHexColor(0xFF6F6F6F);
        _imageLbl.font = kSysFont(12);
        [self addSubview:_imageLbl];
    }
    return _imageLbl;
}



@end
