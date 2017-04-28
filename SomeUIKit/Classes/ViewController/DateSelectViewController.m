//
//  DateSelectViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/11/5.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "DateSelectViewController.h"
#import "WQAlertController.h"
#import "WQSelectDateController.h"
@interface DateSelectViewController ()
@property (strong ,nonatomic) UIDatePicker *myDatePicker;

@end

@implementation DateSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myDatePicker = [[UIDatePicker alloc] init];
    _myDatePicker.bounds = CGRectMake(0, 0, AlertCenterWidth, 200);
    _myDatePicker.datePickerMode = UIDatePickerModeDate;
    
}
- (IBAction)alertAction:(UIButton *)sender {
    if(sender.tag == 1){
        WQSelectDateController *dateAlert = [WQSelectDateController dateWithTitle:@"选择日期" alertStyle:UIAlertControllerStyleActionSheet dateDidChange:NULL confirmSelected:^(WQSelectDateController * _Nonnull dateController, NSDate * _Nonnull date) {
            
        } cancelSelected:NULL];
        [dateAlert showInController:self.navigationController];
    }else{
        WQAlertController *alert = [WQAlertController alertViewWithTitle:@"选择日期" centerView:_myDatePicker];
        alert.titleView.titleAttribute = @{NSFontAttributeName :[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName :[UIColor redColor]};
    //    alert.titleView.titleLabel.font = [UIFont systemFontOfSize:18.0];
    //    alert.titleView.titleLabel.textColor = [UIColor redColor];
        [alert showInViewController:self];
    
    
        //__weak
        [alert addActionType:ActionCancel action:^(WQAlertController * _Nonnull alertViewController) {
            sender.backgroundColor = [UIColor redColor];
    //        [alertViewController dismissViewControllerAnimated:YES completion:NULL];
             [alertViewController popCenterViewAnimate:YES];
    
        }];
        [alert addActionType:ActionConfirm action:^(WQAlertController * _Nonnull alertViewController) {
            UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AlertCenterWidth, 100)];
            UITextField *textView = [[UITextField alloc] init];
            textView.frame = CGRectMake(10, 30, AlertCenterWidth - 20, 50);
            textView.borderStyle = UITextBorderStyleRoundedRect;
            [centerView addSubview:textView];
            alertViewController.titleView.title = @"输入内容";
            alertViewController.bottomView.cancelTitle = @"下一项"
            ;
            [alertViewController pushCenterView:centerView animate:YES];
        }];
    }
    
//
    
}

@end
