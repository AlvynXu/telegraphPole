//
//  XMProjectDetailCell.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMProjectDetailCell.h"
#import "QKLabel.h"


@interface XMProjectDetailCell()

@property(nonatomic, strong)UIImageView *bgImgV;

@property(nonatomic, strong)UILabel *contenLbl;  // 文字

@property(nonatomic, strong)UIImageView *imageV;  // 图片封面

@property(nonatomic, strong)UIImageView *coverImageView;  // 视频封面

@end

@implementation XMProjectDetailCell

CGFloat projectDetail_bottom = 10;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        [self initContenMovie];
    }
    return self;
}

- (void)setItemModel:(XMProjectListItemModel *)itemModel
{
    _itemModel = itemModel;
    
    if (itemModel.type == 1) {  // 文字
        [self initContenLbl];
        self.contenLbl.text = itemModel.desc;
    }
    if (itemModel.type == 2) {  // 图片
        [self initContenImg];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:itemModel.filePath]];
    }
    if (itemModel.type == 3) {  // 视频
        [self initContenMovie];
        [self.coverImageView getMovieImage:itemModel.filePath];
    }
}

// 初始化文字
- (void)initContenLbl
{

    self.imageV.hidden = YES;
    self.coverImageView.hidden = YES;
    self.playBtn.hidden = YES;
    self.contenLbl.hidden = NO;
    self.bgImgV.hidden = YES;
    
    [self.contenLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(@0);
        make.bottom.equalTo(self.mas_bottom).offset(-projectDetail_bottom);
    }];
}
// 初始化图片
- (void)initContenImg
{
    self.contenLbl.hidden = YES;
    self.coverImageView.hidden = YES;
    self.playBtn.hidden = YES;
    self.imageV.hidden = NO;
    self.bgImgV.hidden = YES;
    
    [self.imageV whenTapImageViewChangeBigImage];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(@0);
        make.bottom.equalTo(self.mas_bottom).offset(-projectDetail_bottom);
    }];
}
// 初始化视频
- (void)initContenMovie
{
    self.imageV.hidden = YES;
    self.contenLbl.hidden = YES;
    self.coverImageView.hidden = NO;
    self.playBtn.hidden = NO;
    self.bgImgV.hidden = NO;
    
    [self.bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(@0);
        make.bottom.equalTo(self.mas_bottom).offset(-projectDetail_bottom);
    }];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgImgV);
        
        make.height.width.equalTo(self.bgImgV);
    }];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@44);
        make.height.equalTo(@44);
        make.center.equalTo(self.coverImageView);
    }];
    
    
}

- (UILabel *)contenLbl
{
    if (!_contenLbl) {
        _contenLbl = [[UILabel alloc] init];
        _contenLbl.numberOfLines = 0;
        _contenLbl.font = kSysFont(16);
        [self addSubview:_contenLbl];
    }
    return _contenLbl;
}

- (UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        [_imageV setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _imageV.contentMode =  UIViewContentModeScaleAspectFill;
        _imageV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _imageV.clipsToBounds  = YES;
        [self addSubview:_imageV];
    }
    return _imageV;
}

- (UIImageView *)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.tag = 300;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
        _coverImageView.userInteractionEnabled = YES;
        [self.bgImgV addSubview:_coverImageView];
    }
    return _coverImageView;
}

- (UIButton *)playBtn
{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:kGetImage(@"new_allPlay_44x44_") forState:UIControlStateNormal];
        [self.coverImageView addSubview:_playBtn];
    }
    return _playBtn;
}

- (UIImageView *)bgImgV
{
    if (!_bgImgV) {
        _bgImgV = [UIImageView new];
        _bgImgV.image = kGetImage(@"loading_bgView");
        _bgImgV.userInteractionEnabled = YES;
        [self.contentView addSubview:_bgImgV];
    }
    return _bgImgV;
}


@end
