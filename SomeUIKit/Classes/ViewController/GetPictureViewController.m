//
//  GetPictureViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/10/20.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "GetPictureViewController.h"
#import "WQSelectPhotoViewController.h"
#import "WQShareActionViewController.h"

@interface GetPictureViewController ()<PhotoSelectedViewControllerDelegate,ShareActionDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong ,nonatomic) dispatch_source_t timer;
@end

@implementation GetPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnAction:(UIButton *)sender {
    WQSelectPhotoViewController *photoView = [[WQSelectPhotoViewController alloc] init];
    photoView.delegate = self;
    [photoView showInController:self];
}
- (IBAction)ShareUI:(UIButton *)sender {
    WQShareActionViewController *photoView = [[WQShareActionViewController alloc] init];
    photoView.delegate = self;
    [photoView showInController:self];
    
}
#pragma mark -- PhotoSelectedViewControllerDelegate
-(void)photoSelectedViewDidFinshSelectedImage:(UIImage *)image{
    self.imageView.image = image;
}
- (IBAction)countDownAD:(UIButton *)sender {
    [self launchADWithLastVersion:nil];
}
// MARK: 作为启动页在 [self.window makeKeyAndVisible]之后才起作用
-(void)launchADWithLastVersion:(NSString *)lastVersion{
    // 当前软件的版本号（从Info.plist中获得）
    
//    NSString *currentVersion =[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
//    if(![lastVersion isEqualToString:currentVersion]) return;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"ADImage"];
    imageView.frame = [UIApplication sharedApplication].delegate.window.bounds;
    [[UIApplication sharedApplication].delegate.window addSubview:imageView];
    
    
    __block int32_t timeOutCount= 10;
    
    UIButton *label = [[UIButton alloc] init];
    [label setTitle:[NSString stringWithFormat:@"还剩 %ds",timeOutCount] forState:UIControlStateNormal];
    [label setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [label addTarget:self action:@selector(jumpAD) forControlEvents:UIControlEventTouchUpInside];
    
    label.frame = CGRectMake(APP_WIGHT - 130, 20, 100, 20);
    [imageView addSubview:label];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行一次 (没有这个下面可能到结束了 才执行)
    dispatch_source_set_event_handler(_timer, ^{
        if (timeOutCount <= 1) {
            dispatch_source_cancel(_timer);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [label setTitle:[NSString stringWithFormat:@"还剩 %ds",timeOutCount] forState:UIControlStateNormal];
            });
            timeOutCount --;
        }
    });

    dispatch_source_set_cancel_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [label removeFromSuperview];
            [UIView animateWithDuration:0.5 animations:^{
                imageView.alpha = 0.0;
            } completion:^(BOOL finished) {
                
                [imageView removeFromSuperview];
            }];
        });
    });
    dispatch_resume(_timer);
}
-(void)jumpAD{
    dispatch_source_cancel(_timer);
}
#pragma mark -- ShareActionDelegate
-(void)shareActionDidSelected:(WQShareActionItem *)item{
    NSLog(@"%@",item);
}
@end
