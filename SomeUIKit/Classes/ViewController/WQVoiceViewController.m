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
    // Do any additional setup after loading the view.
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
    WQVoicePlayManager *mgr =  [WQVoicePlayManager manager];
    
    [mgr.downloader setConvertVoiceStyle:WQConvertBase64AmrToWav];
    [mgr play:@"http://123.56.148.205/upload/audio/865555555555553/2/aud_58aeba23f30b9.txt" playFinsh:^(NSError *error, NSString *urlStr, BOOL finshed) {
        
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
