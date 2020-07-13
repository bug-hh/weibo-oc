//
//  StatusCellBottomView.m
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "StatusCellBottomView.h"

@interface StatusCellBottomView ()

@property(strong, nonatomic) UIButton *retweetButton;
@property(strong, nonatomic) UIButton *commentButton;
@property(strong, nonatomic) UIButton *likeButton;
@property(strong, nonatomic) UIView *sp1;
@property(strong, nonatomic) UIView *sp2;

@end

@implementation StatusCellBottomView

- (UIButton *)retweetButton {
    if (!_retweetButton) {
        _retweetButton = [[UIButton alloc] initWithForegroundImageName:@"timeline_icon_retweet" andTitle:@"转发" andFontSize:12];
    }
    return _retweetButton;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [[UIButton alloc] initWithForegroundImageName:@"timeline_icon_comment" andTitle:@"评论" andFontSize:12];
    }
    return _commentButton;
}

- (UIButton *)likeButton {
    if (!_likeButton) {
        _likeButton = [[UIButton alloc] initWithForegroundImageName:@"timeline_icon_unlike" andTitle:@"赞" andFontSize:12];
    }
    return _likeButton;
}

- (UIView *)sp1 {
    if (!_sp1) {
        _sp1 = [[UIView alloc] init];
        _sp1.backgroundColor = [UIColor darkGrayColor];
    }
    return _sp1;
}

- (UIView *)sp2 {
    if (!_sp2) {
        _sp2 = [[UIView alloc] init];
        _sp2.backgroundColor = [UIColor darkGrayColor];
    }
    return _sp2;
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
    self.backgroundColor = [[UIColor alloc] initWithWhite:0.9 alpha:1.0];
    
    [self addSubview:self.retweetButton];
    [self addSubview:self.commentButton];
    [self addSubview:self.likeButton];
    [self addSubview:self.sp1];
    [self addSubview:self.sp2];
    
    [self setupLayout];
}

- (void)setupLayout {
    for (UIView *v in self.subviews) {
        v.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // 设置自动布局
    NSLayoutConstraint *retweetButtonLeft = [NSLayoutConstraint constraintWithItem:self.retweetButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *retweetButtonTop = [NSLayoutConstraint constraintWithItem:self.retweetButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *retweetButtonBottom = [NSLayoutConstraint constraintWithItem:self.retweetButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    [self addConstraint:retweetButtonLeft];
    [self addConstraint:retweetButtonTop];
    [self addConstraint:retweetButtonBottom];
    
    NSLayoutConstraint *commentButtonTop = [NSLayoutConstraint constraintWithItem:self.commentButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.retweetButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *commentButtonLeft = [NSLayoutConstraint constraintWithItem:self.commentButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.retweetButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *commentButtonWidth = [NSLayoutConstraint constraintWithItem:self.commentButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.retweetButton attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *commentButtonHeight = [NSLayoutConstraint constraintWithItem:self.commentButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.retweetButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    [self addConstraint:commentButtonTop];
    [self addConstraint:commentButtonLeft];
    [self addConstraint:commentButtonWidth];
    [self addConstraint:commentButtonHeight];

    NSLayoutConstraint *likeButtonTop = [NSLayoutConstraint constraintWithItem:self.likeButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.commentButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *likeButtonLeft = [NSLayoutConstraint constraintWithItem:self.likeButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.commentButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *likeButtonWidth = [NSLayoutConstraint constraintWithItem:self.likeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.commentButton attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *likeButtonHeight = [NSLayoutConstraint constraintWithItem:self.likeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.commentButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *likeButtonRight = [NSLayoutConstraint constraintWithItem:self.likeButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    
    [self addConstraint:likeButtonTop];
    [self addConstraint:likeButtonLeft];
    [self addConstraint:likeButtonWidth];
    [self addConstraint:likeButtonHeight];
    [self addConstraint:likeButtonRight];
    
    NSLayoutConstraint *sp1CenY = [NSLayoutConstraint constraintWithItem:self.sp1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.retweetButton attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    NSLayoutConstraint *sp1Left = [NSLayoutConstraint constraintWithItem:self.sp1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.retweetButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *sp1Width = [NSLayoutConstraint constraintWithItem:self.sp1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.5];
    NSLayoutConstraint *sp1Height = [NSLayoutConstraint constraintWithItem:self.sp1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.retweetButton attribute:NSLayoutAttributeHeight multiplier:0.4 constant:0];
    
    [self addConstraint:sp1CenY];
    [self addConstraint:sp1Left];
    [self addConstraint:sp1Width];
    [self addConstraint:sp1Height];
    
    NSLayoutConstraint *sp2CenY = [NSLayoutConstraint constraintWithItem:self.sp2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.retweetButton attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    NSLayoutConstraint *sp2Left = [NSLayoutConstraint constraintWithItem:self.sp2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.commentButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *sp2Width = [NSLayoutConstraint constraintWithItem:self.sp2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.5];
    NSLayoutConstraint *sp2Height = [NSLayoutConstraint constraintWithItem:self.sp2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.retweetButton attribute:NSLayoutAttributeHeight multiplier:0.4 constant:0];
    
    [self addConstraint:sp2CenY];
    [self addConstraint:sp2Left];
    [self addConstraint:sp2Width];
    [self addConstraint:sp2Height];
}
@end
