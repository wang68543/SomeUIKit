//
//  CommonAlertViewController.h
//  SomeUIKit
//
//  Created by WangQiang on 2016/11/2.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WQAlertController;

//@protocol CommonAlertDelegate<NSObject>
//-(void)commonAlertDidConfirm:(nonnull CommonAlertViewController *)commonAlert;
//@optional
//-(void)commonAlertDidCancel:(nonnull CommonAlertViewController *)commonAlert;
//
//@end
@class AlertBottomView;
@class AlertTitleView;
#define AlertCenterWidth (APP_WIGHT - 50)
UIKIT_EXTERN  NSString * _Nonnull const ActionConfirm;
UIKIT_EXTERN  NSString * _Nonnull const ActionCancel;

typedef void(^BottomAction)( WQAlertController * _Nonnull alertController);
#pragma mark -- -alertView
@class AlertBottomView;
@protocol AlertBottomViewDelegate<NSObject>
@optional
-(void)bottomViewDidConfirm:(nonnull AlertBottomView *)bottomView;
-(void)bottomViewDidCancel:(nonnull AlertBottomView *)bottomView;
@end
@interface AlertBottomView:UIView
@property (nullable, weak ,nonatomic,readonly) UIButton *confirmBtn;
@property (nullable, weak ,nonatomic,readonly) UIButton *cancleBtn;
@property (nullable, weak ,nonatomic,readonly) UIView *topLine;
@property (nullable, weak ,nonatomic,readonly) UIView  *midleLine;

@property (nullable,weak ,nonatomic) id<AlertBottomViewDelegate> delegate;
+(nullable instancetype)bottomViewWithConfirmTitle:(nullable NSString *)confirmTitle cacelTitle:(nullable NSString *)cancelTitle;
+(nonnull instancetype)bottomView;
@end
#pragma mark -- -AlertTitleView
@interface AlertTitleView : UIView
@property (nullable, weak, nonatomic,readonly) UILabel *titleLabel;
@property (nullable, weak, nonatomic,readonly) UIImageView *iconView;
@property (nullable, weak ,nonatomic,readonly) UIView *lineView;
+(nonnull instancetype)titleView;
@end

@interface WQAlertController : UIViewController
+(nonnull instancetype)alertWithContent:(nonnull NSString *)content;
+(nonnull instancetype)alertWithCenterView:(nonnull UIView *)centerView;
+(nonnull instancetype)alertWithCenterView:(nonnull UIView *)centerView isNeedBottomView:(BOOL)needBottom;
+(nullable instancetype)alertWithContent:(nonnull NSString *)content
                                   title:(nullable NSString *)title;

+(nonnull instancetype)alertViewWithIcon:(nonnull NSString *)titleIcon
                              centerView:(nonnull UIView *)centerView;
+(nonnull instancetype)alertViewWithTitle:(nonnull NSString *)title
                               centerView:(nonnull UIView *)centerView;
/**
 创建弹出框

 @param title       弹出框的标题
 @param titleIcon   弹出框的图标
 @param centerView  自定义的View
 @param confirmitle 确定按钮标题
 @param cancelTitle 取消按钮标题
 */
+(nonnull instancetype)alertViewWithTitle:(nullable NSString *)title
                                titleIcon:(nullable NSString *)titleIcon
                               centerView:(nonnull UIView *)centerView
                             confirmTitle:( nullable NSString *)confirmitle
                              cancelTitle:(nullable NSString *)cancelTitle;
@property (strong ,nonatomic,nullable) UIColor *tintColor;

-(void)addActionType:(nonnull NSString *const)type action:(nonnull BottomAction)action;

/**
 中途添加中间视图

 @param centerView 需要添加的中间视图
 */
-(void)pushCenterView:(nonnull UIView *)centerView animate:(BOOL)animate;
/**
 弹出中间视图
 */
-(void)popCenterViewAnimate:(BOOL)animate;

/**
 弹出中间视图
 */
-(void)showInViewController:(nullable UIViewController *)inViewController;

//@property (weak ,nonatomic,nullable) id<CommonAlertDelegate> delegate;

@property (nullable,strong ,nonatomic,readonly) AlertTitleView *titleView;

@property (strong ,nonatomic,nullable ,readonly) AlertBottomView *bottomView;

@property (strong ,nonatomic,nonnull ,readonly) UIView *topCenterView;

@property (strong ,nonatomic,nonnull ,readonly) NSMutableArray *centerViews;

@end
