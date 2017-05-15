//
//  WQVoiceViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/4/16.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQVoiceViewController.h"
#import "WQVoicePlayManager.h"
#import "WQVoiceRecordManager.h"

@interface WQVoiceViewController ()
@property (strong ,nonatomic) WQVoiceRecordManager *manger;
@property (strong ,nonatomic) WQVoicePlayManager *playManager;


@end

@implementation WQVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取系统自带滑动手势的target对象
//    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//    
//    // 设置手势代理，拦截手势触发
//    pan.delegate = self;
    
    // 给导航控制器的view添加全屏滑动手势
//    [self.view addGestureRecognizer:pan];
    
    // 禁止使用系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
}

// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}
- (IBAction)record:(UIButton *)sender {
    self.manger = [WQVoiceRecordManager manager];
    [self.manger recordWithPathExtension:@"wav"];
    
}
- (IBAction)stopRecord:(UIButton *)sender {
    [self.manger stopRecord:^BOOL(NSString *voicePath, CGFloat duration, NSError *error) {
        NSLog(@"==%@",voicePath);
         return NO;
    }];
}
- (IBAction)play:(UIButton *)sender {
//    WQVoiceDownloader *downloader = [[WQVoiceDownloader alloc] init];
//    WQVoicePlayManager *mgr =  [WQVoicePlayManager manager];
    //下载的是amr格式的语音 需要转换为wav格式
    [[WQVoicePlayManager manager].downloader setConvertVoiceStyle:WQConvertBase64AmrToWav];
    [[WQVoicePlayManager manager] play:@"http://123.56.148.205/upload/audio/865555555555553/2/aud_58aeba23f30b9.txt" playFinsh:^(NSError *error, NSString *urlStr, BOOL finshed) {
        
    }];
}
- (IBAction)stopPlay:(UIButton *)sender {
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
