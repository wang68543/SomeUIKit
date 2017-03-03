//
//  ViewController.h
//  SomeUIKit
//
//  Created by WangQiang on 2016/10/20.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController

@property (strong ,nonatomic) NSArray *titleArray;
@property (strong ,nonatomic) NSArray *viewControllers;
@property (strong ,nonatomic) NSMutableDictionary *params;
@end

