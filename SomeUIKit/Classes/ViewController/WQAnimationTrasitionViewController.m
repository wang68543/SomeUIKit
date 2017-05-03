//
//  WQAnimationTrasitionViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/6.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQAnimationTrasitionViewController.h"
#import "WQControllerTransition.h"
#import "WQSubTransitionViewController.h"
#import "WQAlertController.h"
#import "WQPresentationController.h"

@interface WQAnimationTrasitionViewController ()<UIPopoverPresentationControllerDelegate>
@property (strong ,nonatomic) WQControllerTransition *frameChangeTransition;

@end

@implementation WQAnimationTrasitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(IBAction)viewTransition:(UIButton *)btn{
    WQSubTransitionViewController *viewController = [[WQSubTransitionViewController alloc] init];
    viewController.view.backgroundColor = [UIColor greenColor];
    

    self.frameChangeTransition = [[WQControllerTransition alloc] init];
//    self.frameChangeTransition.showOneSubViewType = ShowOneSubviewTypeCustom;
    self.frameChangeTransition.showSuperViewType = ShowSuperViewTypeFrameChange;//ShowSuperViewTypeFrameChange;
    
    self.frameChangeTransition.orignalFrame = btn.frame;
    self.frameChangeTransition.targetFrame = self.view.frame;
    viewController.view.backgroundColor = [UIColor colorWithRed:66.0/255.0 green:191.0/255.0 blue:193.0/255.0 alpha:1.0];
    viewController.transitioningDelegate = self.frameChangeTransition;
    //    self.modalTransitionStyle 系统的翻页效果
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    
    
    [self.navigationController presentViewController:viewController animated:YES completion:NULL];
}
//直接自定义转场控制器
- (IBAction)otherTransition:(UIButton *)sender {
    WQSubTransitionViewController *viewController = [[WQSubTransitionViewController alloc] init];
    viewController.view.backgroundColor = [UIColor greenColor];
    
    
    self.frameChangeTransition = [[WQControllerTransition alloc] init];
    //    self.frameChangeTransition.showOneSubViewType = ShowOneSubviewTypeCustom;
    self.frameChangeTransition.orignalFrame = sender.frame;
    self.frameChangeTransition.showSuperViewType = ShowSuperViewTypeDismissal;//ShowSuperViewTypeFrameChange;
//    viewController.transitioningDelegate = self.frameChangeTransition;
//    //    self.modalTransitionStyle 系统的翻页效果
//    viewController.modalPresentationStyle = UIModalPresentationCustom;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    nav.transitioningDelegate = self.frameChangeTransition;
    //    self.modalTransitionStyle 系统的翻页效果
    nav.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:nav animated:YES completion:NULL];
    
}

//  ————————————— UIViewController.m 在此处弹出

/**
 UIPresentationController 是 iOS8 新增的一个 API，用来控制 controller 之间的跳转特效。比如希望实现一个特效，显示一个窗口，大小和位置都是自定义的，并且遮罩在原来的页面上。在之前，可以操作view的一些方法来实现。
 */
//- (IBAction)otherTransition:(UIButton *)sender {
// WQSubTransitionViewController *viewController = [[WQSubTransitionViewController alloc] init];WQPresentationController *presentationC = [[WQPresentationController alloc] initWithPresentedViewController:viewController presentingViewController:self];
//   viewController.transitioningDelegate = presentationC ;  // 指定自定义modal动画的代理
//    viewController.view.backgroundColor = [UIColor greenColor];
// [self presentViewController:viewController animated:YES completion:nil];
//}
//带箭头的弹出框
- (IBAction)arrowPopAction:(UIButton *)sender {
    UIViewController *popVC = [[UIViewController alloc] init];
    popVC.modalPresentationStyle = UIModalPresentationPopover;
    // 弹出视图的大小
    popVC.preferredContentSize = CGSizeMake(300, 200);
    
    // 弹出视图设置
    UIPopoverPresentationController *popver = popVC.popoverPresentationController;
    popver.delegate = self;
    //弹出时参照视图的大小，与弹框的位置有关
    popver.sourceRect = sender.bounds;
    //弹出时所参照的视图，与弹框的位置有关
    popver.sourceView = sender;
    //弹框的箭头方向
    popver.permittedArrowDirections = UIPopoverArrowDirectionDown;
    
    popver.backgroundColor = [UIColor orangeColor];
    [self presentViewController:popVC animated:YES completion:nil];

}
// 默认返回的是覆盖整个屏幕，需设置成UIModalPresentationNone。
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}
// 设置点击蒙版是否消失，默认为YES
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}
// 弹出视图消失后调用的方法
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
}


- (IBAction)centerAlert:(UIButton *)sender {
    
    WQAlertController *alert = [WQAlertController alertWithContent:@"弹出内容" title:@"标题"];
    [alert showInViewController:self.navigationController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
