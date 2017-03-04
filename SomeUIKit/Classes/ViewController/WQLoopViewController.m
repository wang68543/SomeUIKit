//
//  WQLoopViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/11/8.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "WQLoopViewController.h"
#import "WQBannerLoopView.h"
#import "WQKeyboardAdjustHelp.h"
@interface WQLoopViewController (){
    WQBannerLoopView *_scrollView;
}

@end

@implementation WQLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //如果View是Xib创建 这里的宽高实际为Xib初始的宽高
    _scrollView = [[WQBannerLoopView alloc] initWithFrame:CGRectMake(0, 100, APP_WIGHT, 400)];
    [self.view addSubview:_scrollView];
    _scrollView.datas = @[@"00.jpg",@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg",@"05.jpg",@"06.jpg",@"07.jpg"];
    [WQKeyboardAdjustHelp keyboardAdjustHelpWithView:self.view excludeTag:NSNotFound];
    
    
}


@end
