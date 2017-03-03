//
//  NSDate+FormatStringExtension.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/11/30.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "NSDate+FormatStringExtension.h"

@implementation NSDate (FormatStringExtension)
-(NSString *)formatTime:(NSString *)formatter{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = formatter;
    NSString *formatTime = [formater stringFromDate:self];
    return formatTime;
}
@end
