//
//  NSDate+Extension.h
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extension)

+ (instancetype)sinaDateWithString:(NSString*)str;
- (NSString*)getDateDescription;

@end

NS_ASSUME_NONNULL_END
