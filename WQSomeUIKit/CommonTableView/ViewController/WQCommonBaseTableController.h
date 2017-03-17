//
//  WQCommonBaseTableController.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/13.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WQCommonGroup.h"
#import "WQCommonBaseCell.h"

@interface WQCommonBaseTableController : UITableViewController
@property (strong ,nonatomic,readonly) NSArray<WQCommonGroup *> *groups;

-(void)addGroups:(NSArray <WQCommonGroup *>*)groups;
@end
