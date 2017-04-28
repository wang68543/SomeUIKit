//
//  NSString+Date.h
//  WeiDa
//
//  Created by WangQiang on 2017/2/25.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WQDate)

/**下划线表示- 2表示汉字 3表示:  4表示斜杠/ 其余的使用日期本身的本地化 00表示空格*/
-(NSDate *)formatMillionSecondsToDate;
/** yyyy-MM-dd HH:mm:ss */
-(NSDate *)formatyyyy_MM_dd00HH3mm3ssToDate;
@end
