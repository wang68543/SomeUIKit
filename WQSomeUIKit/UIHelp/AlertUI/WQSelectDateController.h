//
//  WQSelectDateController.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/4/24.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WQSelectDateController;

typedef void(^_Nullable ConfirmDate)(WQSelectDateController * _Nonnull dateController,NSDate * _Nonnull date);
typedef void(^_Nullable ChangeDate)( NSDate * _Nullable date);
typedef void(^_Nullable CancelDate)(WQSelectDateController * _Nonnull dateController);

@interface WQSelectDateController : UIViewController
@property (strong ,nonatomic,readonly,nonnull) UIDatePicker *datePicker;
@property (assign ,nonatomic,readonly) UIAlertControllerStyle alertControllerStyle;
+(nonnull instancetype)dateWithTitle:(nullable NSString *)title
                          alertStyle:(UIAlertControllerStyle)alertStyle
                       dateDidChange:(ChangeDate)didChange
                     confirmSelected:(ConfirmDate)confirmDate
                      cancelSelected:(CancelDate)cancelDate;
@property (assign ,nonatomic) BOOL enableTapGR;
-(void)showInController:(nullable UIViewController *)viewController;
@end
