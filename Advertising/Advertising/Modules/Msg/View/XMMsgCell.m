//
//  XMMsgCell.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/1.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMsgCell.h"

@interface XMMsgCell ()

@property(nonatomic, strong)UIView *contentV;

@property(nonatomic, strong)UIImageView *imgV;

@property(nonatomic, strong)UILabel *titleLbl;

@property(nonatomic, strong)UILabel *timeLbl;
@property(nonatomic, strong)UILabel *contentLbl;

@end

@implementation XMMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.contentView.backgroundColor = UIColor.clearColor;
   
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(@15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.left.equalTo(@30);
        make.width.equalTo(@5);
        make.height.equalTo(@25);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgV.mas_centerY);
        make.height.equalTo(@30);
        make.left.equalTo(self.imgV.mas_right).offset(10);
    }];
    
    [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self.titleLbl);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.width.equalTo(@130);
    }];
    
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLbl.mas_bottom).offset(20);
        make.left.equalTo(@30);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
}

- (void)setMsgItemModel:(XMMsgItemModel *)msgItemModel
{
    _msgItemModel = msgItemModel;
    self.contentLbl.text = msgItemModel.content;
    self.titleLbl.text = msgItemModel.sender;
    self.timeLbl.text =  [NSString timestampToTimeStr:msgItemModel.createTime.integerValue / 1000 withFormat:@"yyyy-MM-dd HH:mm"];
}


// 配置cell高亮状态
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (_noRead) {
        if (highlighted) {
            self.contentV.backgroundColor = kMainColor;
        } else {
            // 增加延迟消失动画效果，提升用户体验
            [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.contentV.backgroundColor = [UIColor whiteColor];
            } completion:nil];
        }
    }
}

- (UIView *)contentV
{
    if (!_contentV) {
        _contentV = [[UIView alloc] init];
        _contentV.backgroundColor = UIColor.whiteColor;
        _contentV.layer.cornerRadius = 5;
        _contentV.layer.masksToBounds = YES;
        [self.contentView addSubview:_contentV];
    }
    return _contentV;
}

- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        _imgV.backgroundColor = kMainColor;
        [self.contentView addSubview:_imgV];
    }
    return _imgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.text = @"系统消息";
        _titleLbl.font = kBoldFont(16);
        
        [self.contentView addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)timeLbl
{
    if (!_timeLbl) {
        _timeLbl = [[UILabel alloc] init];
        _timeLbl.text = @"2019/11/25 10:20";
        _timeLbl.font = kSysFont(12);
        _timeLbl.textColor = kHexColor(0x999999);
        _timeLbl.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_timeLbl];
    }
    return _timeLbl;
}

- (UILabel *)contentLbl
{
    if (!_contentLbl) {
        _contentLbl = [[UILabel alloc] init];
        _contentLbl.text = @"项目2019发阿发福利卡康师傅将爱福家发了康师傅建安费法拉克就发发";
        _contentLbl.font = kSysFont(14);
        _contentLbl.textColor = kHexColor(0x999999);
        _contentLbl.numberOfLines = 0;
        [self.contentView addSubview:_contentLbl];
    }
    return _contentLbl;
}


@end
