//
//  WQSubTransitionViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/6.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQSubTransitionViewController.h"

@interface WQSubTransitionViewController ()

@end

@implementation WQSubTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 100, 100, 100)];
    [btn addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    
    //对应前面的WQPresentationController
     [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)btnBack:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



//| ----------------------------------------------------------------------------
//对应前面的WQPresentationController
//当屏幕发生旋转的时候会调用这个方法
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    // When the current trait collection changes (e.g. the device rotates),
    // update the preferredContentSize.
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
}


//| ----------------------------------------------------------------------------
//! Updates the receiver's preferredContentSize based on the verticalSizeClass
//! of the provided \a traitCollection.
//
- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection
{
    // 左右留35
    // 上下留80
    
    CGFloat w = self.view.bounds.size.width - 35.f * 2;
    CGFloat h = self.view.bounds.size.height - 80.f * 2;
    
    self.preferredContentSize = CGSizeMake(w,h);
}




- (void)dealloc
{
    NSLog(@"%@ --> dealloc",[self class]);
}

@end
