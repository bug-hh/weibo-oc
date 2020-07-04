//
//  VisitorTableViewController.h
//  weibo-oc
//
//  Created by bughh on 2020/7/3.
//  Copyright © 2020 bughh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisitorView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VisitorTableViewController : UITableViewController

@property (strong, nonatomic) VisitorView *visitorView;

@end

NS_ASSUME_NONNULL_END
