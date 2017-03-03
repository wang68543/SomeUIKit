//
//  IconTitleView.h
//  YunShouHu
//
//  Created by WangQiang on 16/6/2.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertTitleView : UIView
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UIImageView *iconView;
@property (weak ,nonatomic) UIView *lineView;
+(instancetype)titleView;
@end
