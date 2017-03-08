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

@interface WQAnimationTrasitionViewController ()
@property (strong ,nonatomic) WQControllerTransition *frameChangeTransition;

@end

@implementation WQAnimationTrasitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 100, 200, 200)];
    [btn addTarget:self action:@selector(viewTransition:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
}
-(void)viewTransition:(UIButton *)btn{
    WQSubTransitionViewController *viewController = [[WQSubTransitionViewController alloc] init];
    viewController.view.backgroundColor = [UIColor greenColor];
    

    self.frameChangeTransition = [[WQControllerTransition alloc] init];
//    self.frameChangeTransition.showOneSubViewType = ShowOneSubviewTypeCustom;
    self.frameChangeTransition.showSuperViewType = ShowSuperViewTypePresentation;//ShowSuperViewTypeFrameChange;
    
    self.frameChangeTransition.orignalFrame = btn.frame;
    self.frameChangeTransition.targetFrame = self.view.frame;
    self.frameChangeTransition.animationType = AnimationTypeBlipBounce;
    viewController.transitioningDelegate = self.frameChangeTransition;
    //    self.modalTransitionStyle 系统的翻页效果
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    
   
    
    [self.navigationController presentViewController:viewController animated:YES completion:NULL];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
