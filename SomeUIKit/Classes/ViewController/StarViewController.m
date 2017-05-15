//
//  StarViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/10/21.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "StarViewController.h"
#import "WQStarLevel.h"
#import "WQStarContainerView.h"

@interface StarViewController ()
@property (weak, nonatomic) IBOutlet UIView *StarContentView;
@property (weak ,nonatomic) WQStarContainerView *starLevel;
@property (weak, nonatomic) IBOutlet UILabel *starValue;
@end

@implementation StarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WQStarContainerView *starContainerView = [WQStarContainerView starContainerWithFrame:CGRectMake(10, 160, 300, 40) messageWidth:100 message:@"星星评论"];
    [self.view addSubview:starContainerView];
    
//    WQStarLevel *starLevel = [[WQStarLevel alloc] init];
//    [starLevel addTarget:self action:@selector(satrValueChanged:) forControlEvents:UIControlEventValueChanged];
//    starLevel.half = YES;
//    [self.StarContentView addSubview:starLevel];
//    starLevel.backgroundColor = [UIColor whiteColor];
//    starLevel.starHeight = 40;
//    self.starLevel = starLevel;
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    self.starLevel.frame = self.StarContentView.bounds;
}
-(void)satrValueChanged:(WQStarLevel *)level{
    self.starValue.text = [NSString stringWithFormat:@"%.1f",level.starValue];
}
@end
