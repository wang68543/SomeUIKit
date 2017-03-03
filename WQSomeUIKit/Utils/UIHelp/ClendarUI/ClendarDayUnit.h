//
//  ClendarDayUnit.h
//  scrollview
//
//  Created by WangQiang on 16/4/19.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClendarDayUnit.h"

@interface ClendarDayUnit : UICollectionViewCell

@property (strong ,nonatomic) NSDate *date;

@property (strong ,nonatomic) NSArray *models;

@end
