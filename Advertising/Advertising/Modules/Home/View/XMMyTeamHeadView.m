//
//  XMMyTeamHeadView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMyTeamHeadView.h"
#import "XMTeamItemView.h"

@interface XMMyTeamHeadView()

@property(nonatomic, strong)XMTeamItemView *totalPersonV;

@end

@implementation XMMyTeamHeadView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        self.userInteractionEnabled = YES;
        self.image = kGetImage(@"team_heade_base");
    }
    return self;
}

- (void)setup
{
    [self.totalPersonV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(21));
        make.height.equalTo(@(70));
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-13);
    }];
    
    self.goShareImgV = self.totalPersonV.qrCodeImgV;
    self.goShareImgV.userInteractionEnabled = YES;
}


- (void)setTeam:(BOOL)team
{
    _team = team;
//    self.totalPersonV.titleLbl.text = _team?@"直推/总人数":@"历史收益";
    self.totalPersonV.titleLbl.text = @"收支明细";
    [self.totalPersonV hideView:!team];
}

- (void)setHomeMSgModel:(XMHomeMsgModel *)homeMSgModel
{
    _homeMSgModel = homeMSgModel;
    self.totalPersonV.numLbl.text = kFormat(@"%.2lf", homeMSgModel.profit);
}

- (void)setTeamModel:(XMTeamModel *)teamModel
{
    _teamModel = teamModel;
    self.totalPersonV.titleLbl.text = @"直推/总人数";
    self.totalPersonV.numLbl.text = kFormat(@"%zd/%zd人", _teamModel.directCount, _teamModel.totalCount);
}



- (XMTeamItemView *)totalPersonV
{
    if (!_totalPersonV) {
        _totalPersonV = [XMTeamItemView new];
        _totalPersonV.numLbl.text = _team?@"0/0人":@"0";
        _totalPersonV.circleImgV.image = kGetImage(@"person_circle");
        [self addSubview:_totalPersonV];
    }
    return _totalPersonV;
}


@end
