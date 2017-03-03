//
//  UIButtonTitleImageLayoutViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/10/20.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "ButtonTitleImageLayoutViewController.h"
#import "WQEdgeTitleButton.h"

@interface ButtonTitleImageLayoutViewController ()

@end

@implementation ButtonTitleImageLayoutViewController
-(void)loadView{
    UIScrollView *sv = [[UIScrollView alloc] init];
    
    self.view = sv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGSize normalSize = CGSizeMake(100, 80);
    
    WQEdgeTitleButton *leftTilte = [self commonContentTitle];
    leftTilte.titleAliment = ButtonTitleAlimentLeft;
    leftTilte.frame = CGRectMake(20, 80, normalSize.width, normalSize.height);
    
    WQEdgeTitleButton *bottomTilte = [self commonContentTitle];
    bottomTilte.titleAliment = ButtonTitleAlimentBottom;
    bottomTilte.frame = CGRectMake(160, 80, normalSize.width, normalSize.height);
    
    WQEdgeTitleButton *topTilte = [self commonContentTitle];
    topTilte.titleAliment = ButtonTitleAlimentTop;
    topTilte.frame = CGRectMake(20, 200, normalSize.width, normalSize.height);
    
    WQEdgeTitleButton *leftContent = [self commonContentTitle];
    leftContent.titleAliment = ButtonTitleAlimentTop;
    leftContent.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    leftContent.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftContent.frame = CGRectMake(20, 300, 280 , 120);
    
    
    WQEdgeTitleButton *RightContent = [self commonContentTitle];
    RightContent.titleAliment = ButtonTitleAlimentLeft;
    RightContent.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    RightContent.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    RightContent.frame = CGRectMake(20, 430, 280 , 120);

    [self.view setValue:[NSValue valueWithCGSize:CGSizeMake(APP_WIGHT, CGRectGetMaxY(RightContent.frame) + 20)] forKeyPath:@"contentSize"];
}

-(WQEdgeTitleButton *)commonContentTitle{
    WQEdgeTitleButton *edgeBtn = [[WQEdgeTitleButton  alloc] init];
    [edgeBtn setTitle:@"标题" forState:UIControlStateNormal];
    [edgeBtn setImage:[UIImage imageNamed:@"loud_speaker"] forState:UIControlStateNormal];
    
    [edgeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    edgeBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:edgeBtn];
    return edgeBtn;
}
@end
