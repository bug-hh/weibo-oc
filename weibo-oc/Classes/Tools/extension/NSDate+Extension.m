//
//  NSDate+Extension.m
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (instancetype)sinaDateWithString:(NSString*)str {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    df.dateFormat = @"EEE MMM dd HH:mm:ss zzz yyyy";
    return [df dateFromString:str];
}

- (NSString*)getDateDescription {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    if ([calendar isDateInToday:self]) {
        int interval = (int)[[NSDate date] timeIntervalSinceDate:self];
        if (interval < 60) {
            return @"刚刚";
        } else if (interval < 3600) {
            return [NSString stringWithFormat:@"%d 分钟前", interval / 60];
        }
        return [NSString stringWithFormat:@"%d 小时前", interval / 3600];
    }
    
    NSString *fmt = @"HH:mm";
    
    if ([calendar isDateInYesterday:self]) {
        fmt = [NSString stringWithFormat:@"昨天 %@", fmt];
    } else {
        // 一年内
        fmt = [NSString stringWithFormat:@"MM-dd %@", fmt];
        NSComparisonResult result = [calendar compareDate:self toDate:[NSDate date] toUnitGranularity:NSCalendarUnitYear];
        if (result == NSOrderedAscending) {
            fmt = [NSString stringWithFormat:@"yyyy-%@", fmt];
        }
    }
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = fmt;
    df.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    return [df stringFromDate:self];
}
@end
