//
//  WQSelectDateController.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/4/24.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQSelectDateController.h"
#import "WQCommonAlertTitleView.h"
#import "WQCommonAlertBottomView.h"
#import "WQControllerTransition.h"
#import "APPHELP.h"
static NSInteger const DatePickerHeight = 190;

static NSInteger const ToolBarHeight = 44.0;

static NSInteger const BottomViewHeight = 49.0;

static NSInteger const TitleViewHeight = 49.0;

#define CenterAlertWidth ([UIScreen mainScreen].bounds.size.width - 50)

@interface WQSelectDateController ()<WQAlertBottomViewDelegate>
@property (copy ,nonatomic) ChangeDate dateChange;
@property (copy ,nonatomic) ConfirmDate dateConfirm;
@property (copy ,nonatomic) CancelDate dateCancel;

@property (strong ,nonatomic) UIView *containerView;


@property (strong ,nonatomic) WQCommonAlertTitleView *titleView;

@property (strong ,nonatomic) WQCommonAlertBottomView *bottomView;

@property (strong ,nonatomic) WQControllerTransition *bottomTranstion;

@property (strong ,nonatomic) UITapGestureRecognizer *tapGR;

@property (strong ,nonatomic) UIToolbar *toolbar;

@end

@implementation WQSelectDateController

+(instancetype)dateWithTitle:(NSString *)title alertStyle:(UIAlertControllerStyle)alertStyle dateDidChange:(ChangeDate)didChange confirmSelected:(ConfirmDate)confirmDate cancelSelected:(CancelDate)cancelDate{
    return [[self alloc] initWithTitle:title alertStyle:alertStyle dateDidChange:didChange confirmSelected:confirmDate cancelSelected:cancelDate];
}

-(instancetype)initWithTitle:(NSString *)title alertStyle:(UIAlertControllerStyle)alertStyle dateDidChange:(ChangeDate)didChange confirmSelected:(ConfirmDate)confirmDate cancelSelected:(CancelDate)cancelDate{
    if(self = [super init]){
        _alertControllerStyle = alertStyle;
        _dateChange = [didChange copy];
        _dateConfirm = [confirmDate copy];
        _dateCancel = [cancelDate copy];
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        _datePicker = [[UIDatePicker alloc] init];
        if(didChange){
            [_datePicker addTarget:self action:@selector(datePickerDidChange:) forControlEvents:UIControlEventValueChanged];
        }
       
        [self.view addSubview:self.containerView];
        if(alertStyle == UIAlertControllerStyleAlert){
            [self configCenterAlertViewWithTitle:title];
        }else{
            [self configBottomSheetViewWithTitle:title];
        }
         [self.containerView addSubview:_datePicker];
        self.enableTapGR = YES;
    }
    return self;
}
-(UITapGestureRecognizer *)tapGR{
    if(!_tapGR){
        _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackground:)];
    }
    return _tapGR;
}
-(void)tapBackground:(UITapGestureRecognizer *)tapGR{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)setEnableTapGR:(BOOL)enableTapGR{
    _enableTapGR = enableTapGR;
    if(enableTapGR){
        [self.view addGestureRecognizer:self.tapGR];
    }else{
        [self.view removeGestureRecognizer:_tapGR];
    }
}

-(UIToolbar *)toolbar{
    if(!_toolbar){
        _toolbar = [[UIToolbar alloc] init];
    }
    return _toolbar;
}
- (void)configCenterAlertViewWithTitle:(NSString *)alertTitle{
    CGFloat offsetY = 0;
    if(alertTitle){
        _titleView = [WQCommonAlertTitleView titleViewWithTitle:alertTitle icon:nil];
        _titleView.frame = CGRectMake(0, 0, CenterAlertWidth, TitleViewHeight);
        offsetY += TitleViewHeight;
        [_containerView addSubview:_titleView];
    }
    _datePicker.frame = CGRectMake(0, offsetY, CenterAlertWidth, DatePickerHeight);
    _bottomView = [WQCommonAlertBottomView bottomViewWithConfirmTitle:@"确定" cancelTitle:@"取消"];
    _bottomView.delegate = self;
    _bottomView.frame = CGRectMake(0, CGRectGetMaxY(_datePicker.frame), CenterAlertWidth, BottomViewHeight);
    [_containerView addSubview:_bottomView];
    
    _containerView.frame = CGRectMake(0, 0, CenterAlertWidth, CGRectGetMaxY(_bottomView.frame));
    
}
-(void)configBottomSheetViewWithTitle:(NSString *)title{
    NSMutableArray *toolBarItems = [NSMutableArray array];
    UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(bottomViewDidClickConfirmAction)];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(bottomViewDidClickCancelAction)];
//    UIBarButtonItem *fixItem0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    [toolBarItems addObject:fixItem0];
    [toolBarItems addObject:cancelItem];
    UIBarButtonItem *fixItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBarItems addObject:fixItem1];
    if(title){
        
        UIBarButtonItem *titleItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
        [titleItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
        [toolBarItems addObject:titleItem];
        UIBarButtonItem *fixItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBarItems addObject:fixItem2];
    }
    [toolBarItems addObject:confirmItem];
//    UIBarButtonItem *fixItem3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    [toolBarItems addObject:fixItem3];
    [self.containerView addSubview:self.toolbar];
    self.toolbar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ToolBarHeight);
    self.toolbar.items = toolBarItems;
    _datePicker.frame = CGRectMake(0, CGRectGetMaxY(self.toolbar.frame), [UIScreen mainScreen].bounds.size.width, DatePickerHeight);
    _containerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(_datePicker.frame));
}

- (void)datePickerDidChange:(UIDatePicker *)datePicker{
    _dateChange?_dateChange(datePicker.date):nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _datePicker = [[UIDatePicker alloc] init];
}
-(void)showInController:(nullable UIViewController *)viewController{
    if(!viewController){
        viewController = [APPHELP currentNavgationController];
    }
    _bottomTranstion = [WQControllerTransition transitionWithAnimatedView:self.containerView];
    if(_alertControllerStyle == UIAlertControllerStyleAlert){
        _bottomTranstion.showOneSubViewType = ShowOneSubviewFromDownToMiddleCenter;
        _bottomTranstion.animationType = AnimationTypeSpring;
        self.view.backgroundColor = [UIColor whiteColor];
    }else{
        _bottomTranstion.duration = 0.15;
        _bottomTranstion.showOneSubViewType =ShowOneSubviewFromDownToBottom;
        _bottomTranstion.targetBackColor = [UIColor clearColor];
        _containerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _bottomTranstion.animationType = AnimationTypeNormal;
    }
    
    
    self.transitioningDelegate = _bottomTranstion;
    self.modalPresentationStyle = UIModalPresentationCustom;
    [viewController presentViewController:self animated:YES completion:NULL];
    
}

#pragma mark -- WQAlertBottomViewDelegate
-(void)bottomViewDidClickCancelAction{
    if(_dateCancel){
        _dateCancel(self);
    }else{
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
-(void)bottomViewDidClickConfirmAction{
    if(_dateConfirm){
        _dateConfirm(self,self.datePicker.date);
    }else{
       [self dismissViewControllerAnimated:YES completion:NULL]; 
    }
}
@end
