//
//  StatusCell.m
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "StatusCell.h"
#import "UILabel+Convenience.h"

@interface StatusCell ()

@property(strong, nonatomic) StatusCellTopView *statusTopView;
@property(strong, nonatomic) StatusCellBottomView *statusBottomView;

@end

// 单条微博 cell
@implementation StatusCell

#pragma mark - 懒加载控件
- (StatusCellTopView *)statusTopView {
    if (!_statusTopView) {
        _statusTopView = [[StatusCellTopView alloc] init];
    }
    return _statusTopView;
}

- (StatusCellBottomView *)statusBottomView {
    if (!_statusBottomView) {
        _statusBottomView = [[StatusCellBottomView alloc] init];
    }
    return _statusBottomView;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithTitle:@"微博正文" andFontSize:15 andColor:[UIColor darkGrayColor]];
    }
    return _statusLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.statusTopView];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.statusBottomView];
    
    [self setupLayout];
    
}

- (void)setupLayout {
    for (UIView *v in self.contentView.subviews) {
        v.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // top view
    NSLayoutConstraint *topViewTop = [NSLayoutConstraint constraintWithItem:self.statusTopView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *topViewLeft = [NSLayoutConstraint constraintWithItem:self.statusTopView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *topViewRight = [NSLayoutConstraint constraintWithItem:self.statusTopView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    // todo 修改高度
    NSLayoutConstraint *topViewHeight = [NSLayoutConstraint constraintWithItem:self.statusTopView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:2 * StatusCellMargin + StatusCellIconWidth];
    
    [self.contentView addConstraint:topViewTop];
    [self.contentView addConstraint:topViewLeft];
    [self.contentView addConstraint:topViewRight];
    [self.contentView addConstraint:topViewHeight];
    
    // status label
    NSLayoutConstraint *labelLeft = [NSLayoutConstraint constraintWithItem:self.statusLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:StatusCellMargin];
    NSLayoutConstraint *labelTop = [NSLayoutConstraint constraintWithItem:self.statusLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.statusTopView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:StatusCellMargin];
    
    [self.contentView addConstraint:labelLeft];
    [self.contentView addConstraint:labelTop];
    
    // status bottom view

}

- (void)setViewModel:(StatusWeiboViewModel *)viewModel {
    _viewModel = viewModel;
    _statusLabel.text = viewModel.status.text;
}
@end
