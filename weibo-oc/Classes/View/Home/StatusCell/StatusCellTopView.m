//
//  StatusCellTopView.m
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "StatusCellTopView.h"

@interface StatusCellTopView ()

@property(strong, nonatomic) UIView *sepView;
// 头像
@property(strong, nonatomic) UIImageView *iconView;
// 微博名
@property(strong, nonatomic) UILabel *nameLabel;
// 会员等级
@property(strong, nonatomic) UIImageView *memberIcon;
// vip
@property(strong, nonatomic) UIImageView *vipIcon;
// 微博发送时间
@property(strong, nonatomic) UILabel *timeLabel;
// 微博来源
@property(strong, nonatomic) UILabel *sourceLabel;

@end

// 单条微博顶部视图
@implementation StatusCellTopView

#pragma mark - 懒加载控件

- (UIView *)sepView {
    if (!_sepView) {
        _sepView = [[UIView alloc] init];
        _sepView.backgroundColor = [UIColor lightGrayColor];
    }
    return _sepView;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_default_big"]];
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithTitle:@"随便" andFontSize:15 andColor:[UIColor darkGrayColor]];
    }
    return _nameLabel;
}

- (UIImageView *)memberIcon {
    if (!_memberIcon) {
        _memberIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_membership_level6"]];
    }
    return _memberIcon;
}

- (UIImageView *)vipIcon {
    if (!_vipIcon) {
        _vipIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_vip"]];
    }
    return _vipIcon;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithTitle:@"刚刚" andFontSize:12 andColor:[UIColor orangeColor]];
    }
    return _timeLabel;
}

- (UILabel *)sourceLabel {
    if (!_sourceLabel) {
        _sourceLabel = [[UILabel alloc] initWithTitle:@"HH 微博" andFontSize:12 andColor:[UIColor darkGrayColor]];
    }
    return _sourceLabel;
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.sepView];
    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.memberIcon];
    [self addSubview:self.vipIcon];
    [self addSubview:self.timeLabel];
    [self addSubview:self.sourceLabel];
    
    [self setupLayout];
}

- (void)setupLayout {
    
    for (UIView *v in self.subviews) {
        v.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // 设置自动布局
    NSLayoutConstraint *sepViewTop = [NSLayoutConstraint constraintWithItem:self.sepView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *sepViewLeft = [NSLayoutConstraint constraintWithItem:self.sepView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *sepViewRight = [NSLayoutConstraint constraintWithItem:self.sepView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *sepViewHeight = [NSLayoutConstraint constraintWithItem:self.sepView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:StatusCellMargin];
    
    [self addConstraint:sepViewTop];
    [self addConstraint:sepViewLeft];
    [self addConstraint:sepViewRight];
    [self addConstraint:sepViewHeight];

    NSLayoutConstraint *iconViewTop = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.sepView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:StatusCellMargin];
    NSLayoutConstraint *iconViewLeft = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:StatusCellMargin];
    NSLayoutConstraint *iconViewWidth = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:StatusCellIconWidth];
    NSLayoutConstraint *iconViewHeight = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:StatusCellIconWidth];
    
    [self addConstraint:iconViewTop];
    [self addConstraint:iconViewLeft];
    [self addConstraint:iconViewWidth];
    [self addConstraint:iconViewHeight];

    NSLayoutConstraint *nameLabelTop = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *nameLabelLeft = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeRight multiplier:1.0 constant:StatusCellMargin];
    
    [self addConstraint:nameLabelTop];
    [self addConstraint:nameLabelLeft];

    NSLayoutConstraint *memberIconTop = [NSLayoutConstraint constraintWithItem:self.memberIcon attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *memberIconLeft = [NSLayoutConstraint constraintWithItem:self.memberIcon attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:StatusCellMargin];
    
    [self addConstraint:memberIconTop];
    [self addConstraint:memberIconLeft];

    NSLayoutConstraint *vipIconX = [NSLayoutConstraint constraintWithItem:self.vipIcon attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *vipIconY = [NSLayoutConstraint constraintWithItem:self.vipIcon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    [self addConstraint:vipIconX];
    [self addConstraint:vipIconY];
    
    NSLayoutConstraint *timeLabelTop = [NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:StatusCellMargin / 2];
    NSLayoutConstraint *timeLabelLeft = [NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeRight multiplier:1.0 constant:StatusCellMargin];
    
    [self addConstraint:timeLabelTop];
    [self addConstraint:timeLabelLeft];

    NSLayoutConstraint *sourceLabelTop = [NSLayoutConstraint constraintWithItem:self.sourceLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.timeLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *sourceLabelLeft = [NSLayoutConstraint constraintWithItem:self.sourceLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.timeLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:StatusCellMargin];
    
    [self addConstraint:sourceLabelTop];
    [self addConstraint:sourceLabelLeft];
}
@end
