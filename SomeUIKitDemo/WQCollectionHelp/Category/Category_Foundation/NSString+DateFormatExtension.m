//
//  NSString+dateFormatExtension.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/11/30.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "NSString+DateFormatExtension.h"
#import <objc/runtime.h>

@implementation NSString (DateFormatExtension)

-(NSDate *)formatDate:(NSString *)format{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = format;
    NSDate *formatDate = [formater dateFromString:self];
    return formatDate;
}
@end
