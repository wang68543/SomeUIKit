//
//  WQKeyboardHandleViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/1.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQKeyboardHandleViewController.h"
#import "WQKeyboardAdjustHelp.h"

@interface WQKeyboardHandleViewController ()
@property (strong ,nonatomic) WQKeyboardAdjustHelp *keyboardAdjust;

@end

@implementation WQKeyboardHandleViewController
-(void)loadView{
    UIScrollView *sv = [[UIScrollView alloc] init];
    self.view = sv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
    CGFloat y = 200;
    UITextField *tf1 = [self tfWithPlaceHodle:@"第一个输入框"];
    tf1.frame = CGRectMake(20, y, 200, 40);
    y += 60;
    
    UITextField *tf2 = [self tfWithPlaceHodle:@"第二个输入框"];
    tf2.frame = CGRectMake(20, y, 200, 40);
    y += 60;
    
    UITextField *tf3 = [self tfWithPlaceHodle:@"第三个输入框"];
    tf3.frame = CGRectMake(20, y, 200, 40);
    y += 60;
    tf3.keyboardType = UIKeyboardTypePhonePad;
    
    UITextField *tf4 = [self tfWithPlaceHodle:@"第四个输入框"];
    tf4.frame = CGRectMake(20, y, 200, 40);
    y += 60;
    
    
    UITextField *tf5 = [self tfWithPlaceHodle:@"第五个输入框"];
    tf5.frame = CGRectMake(20, y, 200, 40);
    y += 60;
    
    
    _keyboardAdjust = [WQKeyboardAdjustHelp keyboardAdjustHelpWithView:self.view excludeTag:NSNotFound];
    
}


-(UITextField *)tfWithPlaceHodle:(NSString *)placehodle{
    UITextField *tf = [[UITextField alloc] init];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.placeholder = placehodle;
    [self.view addSubview:tf];
    return tf;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
