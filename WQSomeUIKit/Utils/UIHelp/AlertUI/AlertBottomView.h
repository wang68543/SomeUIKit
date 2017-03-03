//
//  BottomView.h
//  YunShouHu
//
//  Created by WangQiang on 16/3/24.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlertBottomView;
@protocol AlertBottomViewDelegate<NSObject>
@optional
-(void)bottomViewDidConfirm:(AlertBottomView *)bottomView;
-(void)bottomViewDidCancel:(AlertBottomView *)bottomView;

@end
@interface AlertBottomView : UIView
@property (weak ,nonatomic) UIButton *confirmBtn;
@property (weak ,nonatomic) UIButton *cancleBtn;

@property (weak ,nonatomic) UIView *topLine;
@property (weak ,nonatomic) UIView  *midleLine;

@property (weak ,nonatomic) id<AlertBottomViewDelegate> delegate;

+(instancetype)bottomViewWithConfirmTitle:(NSString *)confirmTitle cacelTitle:(NSString *)cancelTitle;
+(instancetype)bottomView;

@end
