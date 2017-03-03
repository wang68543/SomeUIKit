//
//  IconTitleView.m
//  YunShouHu
//
//  Created by WangQiang on 16/6/2.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "AlertTitleView.h"

@implementation AlertTitleView

-(instancetype)init{
    if(self = [super init]){
        UIImageView *imageView = [[UIImageView alloc] init];
        self.iconView = imageView;
        [self addSubview:imageView];
        UILabel  *label = [[UILabel alloc] init];
        label.font = MYFontM(20.0);
        label.textColor = TITLE3;
        self.titleLabel = label;
        [self addSubview:label];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.lineView = lineView;
        [self addSubview:lineView];
    }
    return self;
}
+(instancetype)titleView{
    return [[self alloc] init];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.lineView.frame = CGRectMake(0, self.height - 2.0, self.width, 2.0);
    CGFloat leftX = 10.0;
    
    if(_iconView.image){
        CGSize imageSize = _iconView.image.size;
        CGFloat imageH = MIN(CGRectGetHeight(self.frame) - CGRectGetHeight(self.lineView.frame), imageSize.height);
        CGFloat imageY = (CGRectGetHeight(self.frame) - CGRectGetHeight(self.lineView.frame) - imageH)*0.5;
        _iconView.frame = CGRectMake(leftX, imageY, imageSize.width, imageH);
        leftX = CGRectGetMaxX(_iconView.frame)+10.0;
    }
    
    if(_titleLabel.text){
      _titleLabel.frame = CGRectMake(leftX, 0.0, self.width - leftX - 20.0, self.height - self.lineView.height);
    }
}
@end
