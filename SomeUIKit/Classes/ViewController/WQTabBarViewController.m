//
//  WQTabBarViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/11/18.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "WQTabBarViewController.h"
#import "WQControllerTransition.h"

@interface WQTabBarViewController ()
@property (strong ,nonatomic) WQControllerTransition *tabControllerTransition;

@end

@implementation WQTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabControllerTransition = [WQControllerTransition transitionWithTabBarController:self];
//    WQControllerTransition *transition = [WQControllerTransition transitionWithTabBarController:self];
//    self.delegate = transition;
}
-(void)dealloc{
    NSLog(@"tabbarController 销毁");
}
@end
