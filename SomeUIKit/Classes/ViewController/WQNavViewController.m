//
//  WQNavViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/5/2.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQNavViewController.h"
#import "WQControllerTransition.h"

@interface WQNavViewController ()
@property (strong ,nonatomic) WQControllerTransition *transition;

@end

@implementation WQNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.transition = [WQControllerTransition transitionWithNavigationController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
