//
//  XMTeamCell.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMTeamCell.h"

@interface XMTeamCell ()

@property(nonatomic, strong)UIImageView *baseV;

@property(nonatomic, strong)UILabel *nameLbl;  // 姓名

@property(nonatomic, strong)UILabel *timeLbl;  // 时间

@property(nonatomic, strong)UILabel *titleLbl;  //

@property(nonatomic, strong)UILabel *numLbl;  //

@end

@implementation XMTeamCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    [self.baseV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.top.equalTo(@0);
    }];
    
    
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kScaleW(29)));
        make.height.equalTo(@(kScaleH(17)));
        make.top.equalTo(@(kScaleH(17)));
    }];
    
    [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLbl.mas_left);
        make.top.equalTo(self.nameLbl.mas_bottom).offset(13.5);
        make.height.equalTo(@(kScaleH(13)));
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseV.mas_right).offset(-28);
        make.height.equalTo(@(kScaleH(15)));
        make.left.equalTo(self.nameLbl.mas_right).offset(10);
        make.centerY.equalTo(self.nameLbl.mas_centerY);
    }];
    
    [self.numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLbl.mas_right);
        make.left.equalTo(self.timeLbl.mas_right).offset(10);
        make.height.equalTo(@(kScaleH(17)));
        make.centerY.equalTo(self.timeLbl.mas_centerY);
    }];

}

- (void)setTeamModel:(XMTeamPageItemModel *)teamModel
{
    _teamModel = teamModel;
    self.nameLbl.text = teamModel.name;
    self.timeLbl.text = teamModel.time;
    self.numLbl.text = kFormat(@"%zd/%zd", teamModel.directCount, teamModel.totalCount);
}

- (void)setProfitItemModel:(XMProfitPageItemModel *)profitItemModel
{
    _profitItemModel = profitItemModel;
//    self.nameLbl.text = profitItemModel.name;
    self.timeLbl.text = profitItemModel.time;
    self.nameLbl.text = profitItemModel.typeString;
    self.numLbl.text = profitItemModel.amount>0?kFormat(@"+%.2lf", profitItemModel.amount):kFormat(@"%.2lf", profitItemModel.amount);
}


- (void)setTeam:(BOOL)team
{
    _team = team;
    self.titleLbl.text = team?@"直推/总人数":@"历史收益";
}

- (UIImageView *)baseV
{
    if (!_baseV) {
        _baseV = [[UIImageView alloc] init];
        _baseV.image = kGetImage(@"team_item");
        [self addSubview:_baseV];
    }
    return _baseV;
}

- (UILabel *)numLbl
{
    if (!_numLbl) {
        _numLbl = [[UILabel alloc] init];
        _numLbl.font = kBoldFont(18);
        _numLbl.textAlignment = NSTextAlignmentRight;
        _numLbl.textColor = kHexColor(0xFF333333);
        [self.baseV addSubview:_numLbl];
    }
    return _numLbl;
}

- (UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] init];
        _nameLbl.textColor = kHexColor(0xFF333333);
        _nameLbl.font = kSysFont(16);
        [self.baseV addSubview:_nameLbl];
    }
    return _nameLbl;
}

- (UILabel *)timeLbl
{
    if (!_timeLbl) {
        _timeLbl = [[UILabel alloc] init];
        _timeLbl.textColor = kHexColor(0xFF999999);
        _timeLbl.font = kSysFont(13);
        [self.baseV addSubview:_timeLbl];
    }
    return _timeLbl;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.font = kSysFont(13);
        _titleLbl.textAlignment = NSTextAlignmentRight;
        _titleLbl.textColor = kHexColor(0xFF999999);
        [self.baseV addSubview:_titleLbl];
    }
    return _titleLbl;
}



@end
