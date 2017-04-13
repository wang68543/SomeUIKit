//
//  NSString+Date.m
//  WeiDa
//
//  Created by WangQiang on 2017/2/25.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "NSString+WQDate.h"

@implementation NSString (WQDate)
-(NSDate *)millionSecondsToDate{
    NSString *timeSeconds = [self substringToIndex:self.length - 3];
    return [NSDate dateWithTimeIntervalSince1970:timeSeconds.floatValue];
}
//MARK: -- yyyy-MM-dd HH:mm:ss
-(NSDate *)yyyy_MM_dd00HH3mm3ssToDate{
    return [self dateWithFormatString:@"yyyy-MM-dd HH:mm:ss"];
}
-(NSDate *)dateWithFormatString:(NSString *)formatString{
    return  [[self formaterWithFormat:formatString] dateFromString:self];
}
-(NSDateFormatter *)formaterWithFormat:(NSString *)format{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = format;
    return formater;
}
@end
