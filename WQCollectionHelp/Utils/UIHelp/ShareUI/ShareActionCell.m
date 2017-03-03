//
//  ShareActionCell.m
//  AirMonitor
//
//  Created by WangQiang on 16/5/22.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "ShareActionCell.h"
@interface ShareActionCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end
@implementation ShareActionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setItem:(ShareActionItem *)item{
    _item = item;
    self.iconView.image  = [UIImage imageNamed:_item.icon];
}
@end
