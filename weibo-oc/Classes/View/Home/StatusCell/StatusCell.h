//
//  StatusCell.h
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusCellTopView.h"
#import "StatusCellBottomView.h"
#import "StatusWeiboViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StatusCell : UITableViewCell

@property(strong, nonatomic) StatusWeiboViewModel *viewModel;
@property(strong, nonatomic) UILabel *statusLabel;

@end

NS_ASSUME_NONNULL_END
