//
//  WQClanderViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/11/19.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "WQClanderViewController.h"
#import "WQClendarView.h"


@interface WQClanderViewController ()

@end

@implementation WQClanderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WQClendarView *claendar = [[WQClendarView alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 200)];
    [self.view addSubview:claendar];
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
