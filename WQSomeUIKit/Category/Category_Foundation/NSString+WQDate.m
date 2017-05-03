//
//  NSString+Date.m
//  WeiDa
//
//  Created by WangQiang on 2017/2/25.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "NSString+WQDate.h"
#import "WQDateFormater.h"

@implementation NSString (WQDate)
-(NSDate *)formatMillionSecondsToDate{
    NSString *timeSeconds = [self substringToIndex:self.length - 3];
    return [NSDate dateWithTimeIntervalSince1970:timeSeconds.floatValue];
}
//MARK: -- yyyy-MM-dd HH:mm:ss
-(NSDate *)formatyyyy_MM_dd00HH3mm3ssToDate{
    return [self dateWithFormatString:@"yyyy-MM-dd HH:mm:ss"];
}
//MARK: -- yyyy-MM-dd
-(NSDate *)formatyyyy_MM_ddToDate{
    return [self dateWithFormatString:@"yyyy-MM-dd"];
}
-(NSDate *)dateWithFormatString:(NSString *)formatString{
    //频繁创建 NSDateFormatter 比较好性能
    //    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [WQDateFormater manager].dateFormat = formatString;
    return  [[WQDateFormater manager] dateFromString:self];
}
@end
