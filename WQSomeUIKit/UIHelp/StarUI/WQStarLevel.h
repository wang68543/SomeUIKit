//
//  StarLevel.h
//  YunShouHu
//
//  Created by WangQiang on 2016/10/12.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQStarLevel : UIControl

/**
 星星的高度(星星的高度与宽度需相等)
 */
@property (assign ,nonatomic) CGFloat starHeight;

@property (assign ,nonatomic) CGFloat starValue;


/**
 星星高亮的颜色
 */
@property (strong ,nonatomic) UIColor *starHighlightedColor;
/**
 星星正常的(为填充的背景)颜色
 */
@property (strong ,nonatomic) UIColor *starNormalColor;


/**
 边框颜色
 */
@property (strong ,nonatomic) UIColor * borderColor;

/**
 边框宽度
 */
@property (assign ,nonatomic) CGFloat borderWidth;

/**
 是否支持显示半颗星
 */
@property (assign ,nonatomic ,getter=isHalf) BOOL half;
@end
