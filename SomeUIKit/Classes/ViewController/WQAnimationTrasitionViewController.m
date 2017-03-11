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

@interface WQAnimationTrasitionViewController ()
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
    viewController.transitioningDelegate = self.frameChangeTransition;
    //    self.modalTransitionStyle 系统的翻页效果
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    
    
    [self.navigationController presentViewController:viewController animated:YES completion:NULL];
}
- (IBAction)otherTransition:(UIButton *)sender {
    WQSubTransitionViewController *viewController = [[WQSubTransitionViewController alloc] init];
    viewController.view.backgroundColor = [UIColor greenColor];
    
    
    self.frameChangeTransition = [[WQControllerTransition alloc] init];
    //    self.frameChangeTransition.showOneSubViewType = ShowOneSubviewTypeCustom;
    self.frameChangeTransition.showSuperViewType = ShowSuperViewTypeDismissal;//ShowSuperViewTypeFrameChange;
    viewController.transitioningDelegate = self.frameChangeTransition;
    //    self.modalTransitionStyle 系统的翻页效果
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    
    
    [self.navigationController presentViewController:viewController animated:YES completion:NULL];
    
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
