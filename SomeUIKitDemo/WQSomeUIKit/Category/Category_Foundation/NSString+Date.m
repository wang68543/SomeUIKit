//
//  NSString+Date.m
//  WeiDa
//
//  Created by WangQiang on 2017/2/25.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)
-(NSDate *)millionSecondsToDate{
    NSString *timeSeconds = [self substringToIndex:self.length - 3];
    return [NSDate dateWithTimeIntervalSince1970:timeSeconds.floatValue];
}
@end
