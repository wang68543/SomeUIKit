//
//  VerticalScrollTextViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/10/21.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "VerticalScrollTextViewController.h"
#import "GYChangeTextView.h"

@interface VerticalScrollTextViewController ()

@end

@implementation VerticalScrollTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GYChangeTextView *textView = [[GYChangeTextView alloc] init];
    textView.animationTextCount = 3;
    textView.frame = CGRectMake(10, 80, [[UIScreen mainScreen] bounds].size.width - 20, 120);
    [textView animationWithTexts:@[@"第一行文字",@"第二行文字",@"第三行文字",@"第四行文字"]];
    [self.view addSubview:textView];
}

@end
