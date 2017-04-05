//
//  NSDate+Format.m
//  WeiDa
//
//  Created by WangQiang on 2017/2/25.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "NSDate+Format.h"

@implementation NSDate (Format)


/**
 一年中的第几周
 */
-(NSString *)TOw{
    return [self formatDateWithFormat:@"w"];
}
-(NSString *)TOM{
    return [self formatDateWithFormat:@"M"];
}



-(NSString *)TOyyyy_MM_dd{
    return [self formatDateWithFormat:@"yyyy-MM-dd"];
}
-(NSString *)TOMM4dd{
    return [self formatDateWithFormat:@"MM/dd"];
}
-(NSString *)TOyyyy_MM_dd00HH3mm{
    return [self formatDateWithFormat:@"yyyy-MM-dd HH:mm"];
}




-(NSString *)formatDateWithFormat:(NSString *)format{
    return [[self formaterWithFormat:format] stringFromDate:self];
}
-(NSDateFormatter *)formaterWithFormat:(NSString *)format{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = format;
    return formater;
}
@end
