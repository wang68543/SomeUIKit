//
//  TextViewPlacehodelViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/10/21.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "TextViewPlacehodelViewController.h"
#import "PlaceholderTextView.h"

@interface TextViewPlacehodelViewController ()
@property (weak, nonatomic) IBOutlet PlaceholderTextView *placeholder;

@end

@implementation TextViewPlacehodelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.placeholder.placeholder = @"我是textView的占位文字";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
