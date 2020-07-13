//
//  NSString+Sina.m
//  weibo-oc
//
//  Created by bughh on 2020/7/12.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "NSString+Sina.h"

@implementation NSString (Sina)

- (NSString*)href {
    NSString *pattern = @"<a href=\"(.*?)\".*?>(.*?)</a>";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSTextCheckingResult *result = [regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    if (!result) {
        NSLog(@"没有匹配项目");
        return nil;
    }
    
    NSRange range = [result rangeAtIndex:2];
    return [self substringWithRange:range];
}
@end
