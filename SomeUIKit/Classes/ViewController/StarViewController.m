//
//  StarViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/10/21.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "StarViewController.h"
#import "StarLevel.h"

@interface StarViewController ()
@property (weak, nonatomic) IBOutlet UIView *StarContentView;
@property (weak ,nonatomic) StarLevel *starLevel;
@property (weak, nonatomic) IBOutlet UILabel *starValue;
@end

@implementation StarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    StarLevel *starLevel = [[StarLevel alloc] init];
    [starLevel addTarget:self action:@selector(satrValueChanged:) forControlEvents:UIControlEventValueChanged];
    starLevel.half = YES;
    [self.StarContentView addSubview:starLevel];
    starLevel.backgroundColor = [UIColor whiteColor];
    starLevel.starHeight = 40;
    self.starLevel = starLevel;
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.starLevel.frame = self.StarContentView.bounds;
}
-(void)satrValueChanged:(StarLevel *)level{
    self.starValue.text = [NSString stringWithFormat:@"%.1f",level.starValue];
}
@end
