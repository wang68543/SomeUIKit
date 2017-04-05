//
//  WQTableViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/14.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQTableViewController.h"

@interface WQTableViewController ()

@end

@implementation WQTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WQCommonGroup *group1 = [WQCommonGroup commonGroup];
    WQCommonBaseItem *baseItem = [WQCommonBaseItem baseItemWithTitle:@"基本样式"];
    [group1.items addObject:baseItem];
    
    WQCommonArrowItem *arrowItem = [WQCommonArrowItem baseItemWithTitle:@"带箭头的样式"];
    [group1.items addObject:arrowItem];
    
    WQCommonSubtitleItem *subtitleItem = [WQCommonSubtitleItem itemWithIcon:nil title:@"两个标题的样式" subTitle:@"子标题"];
    [group1.items addObject:subtitleItem];
    
    WQCommonSwitchItem *switchItem = [WQCommonSwitchItem baseItemWithTitle:@"开关辅助视图样式"];
    [group1.items addObject:switchItem];
    
    WQCommonGroup *group2 = [WQCommonGroup comomnGroupWithHeder:@"头部" footer:@"底部"];
    WQCommonCenterItem *centerItem = [WQCommonCenterItem baseItemWithTitle:@"退出登录的样式"];
    [group2.items addObject:centerItem];
    [self.tableDataHandle addGroups:@[group1,group2]];
    
    
}


@end
