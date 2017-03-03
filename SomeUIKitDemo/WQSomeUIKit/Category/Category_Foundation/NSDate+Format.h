//
//  NSDate+Format.h
//  WeiDa
//
//  Created by WangQiang on 2017/2/25.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)
-(NSString *)formatDateWithFormat:(NSString *)format;
/**
 一年中的第几周
 
 @return %d(数字)
 */
-(NSString *)TOw;
/**
 M
 @return 第几月(数字)
 */
-(NSString *)TOM;


/**下划线表示- 2表示汉字 3表示:  4表示斜杠/ 其余的使用日期本身的本地化 00表示空格*/
-(NSString *)TOyyyy_MM_dd00HH3mm;
-(NSString *)TOyyyy_MM_dd;
-(NSString *)TOMM4dd;
@end
