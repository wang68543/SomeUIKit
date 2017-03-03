//
//  WQTabBarViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/11/18.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "WQTabBarViewController.h"
#import "ViewControllerTransition.h"

@interface WQTabBarViewController ()
@property (strong ,nonatomic) ViewControllerTransition *tabControllerTransition;

@end

@implementation WQTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabControllerTransition = [ViewControllerTransition transitionWithTabBarController:self];
}
-(void)dealloc{
    NSLog(@"tabbarController 销毁");
}
@end
