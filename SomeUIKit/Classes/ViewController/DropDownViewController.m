//
//  DropDownViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/10/20.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "DropDownViewController.h"
#import "WQSelecOptionsView.h"
#import "ZHAnimationView.h"

@interface DropDownViewController ()

@end

@implementation DropDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)Top:(UIButton *)sender {
    WQSelecOptionsView *timeView = [[WQSelecOptionsView alloc] init];
    timeView.datas = @[@"开始123",@"我是要排除的",@"结束456"];
    timeView.expectData = sender.currentTitle;
    [timeView setTableViewBackGround:[UIColor blueColor]];
    __weak typeof(timeView) weakTime = timeView;
    timeView.didSelectedCompeletionIndexPath = ^(BOOL success,NSIndexPath *slectedIndex){
        if(success){
           NSLog(@"选中了%@===Index:%ld",weakTime.datas[slectedIndex.row],(long)slectedIndex.row);
            [sender setTitle:weakTime.datas[slectedIndex.row] forState:UIControlStateNormal];
        }
    };
    [timeView showWithView:sender];
}

- (IBAction)Bottom:(UIButton *)sender {
    
    WQSelecOptionsView *timeView = [[WQSelecOptionsView alloc] init];
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i < 100 ; i ++) {
        [datas addObject:[NSString stringWithFormat:@"%d",i]];
    }
    timeView.bottomInset = 100;
    
    timeView.datas = datas;
    timeView.selectedData = @"66";
    
    [timeView setTableViewBackGround:[UIColor lightGrayColor]];
    __weak typeof(timeView) weakTime = timeView;
    timeView.didSelectedCompeletionIndexPath = ^(BOOL success,NSIndexPath *slectedIndex){
        if(success){
             [sender setTitle:weakTime.datas[slectedIndex.row] forState:UIControlStateNormal];
            NSLog(@"选中了%@===Index:%ld",weakTime.datas[slectedIndex.row],(long)slectedIndex.row);
        }
    };
    [timeView showWithView:sender];
    
}

@end
