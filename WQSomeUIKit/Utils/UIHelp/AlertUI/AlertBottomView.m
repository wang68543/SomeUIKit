//
//  BottomView.m
//  YunShouHu
//
//  Created by WangQiang on 16/3/24.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "AlertBottomView.h"

@implementation AlertBottomView

+(instancetype)bottomViewWithConfirmTitle:(NSString *)confirmTitle cacelTitle:(NSString *)cancelTitle{
    return [[self alloc] initWithConfirmTitle:confirmTitle cancelTitle:cancelTitle];
}
+(instancetype)bottomView{
    return [self bottomViewWithConfirmTitle:@"确认" cacelTitle:@"取消"];
}
-(instancetype)initWithConfirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle{
    if(self = [super init]){
        if(confirmTitle){
            UIButton *confirm = [[UIButton alloc] init];
            [confirm setTitle:confirmTitle forState:UIControlStateNormal];
            confirm.titleLabel.font = MYFont(17.0);
            [confirm setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [confirm setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
            [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
            confirm.backgroundColor = [UIColor clearColor];
            self.confirmBtn = confirm;
            [self addSubview:confirm];
        }
        if(cancelTitle || (!cancelTitle && !confirmTitle)){
            if(!cancelTitle) cancelTitle = @"取消";
            UIButton *cancle = [[UIButton alloc] init];
            [cancle setTitle:cancelTitle forState:UIControlStateNormal];
            [cancle setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [cancle addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
            cancle.titleLabel.font = MYFont(16.0);
            cancle.backgroundColor = [UIColor clearColor];
            [cancle setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
            self.cancleBtn = cancle;
            [self addSubview:cancle];
        }
        
        if(cancelTitle && confirmTitle){
            UIView *middleLine = [[UIView alloc] init];
            middleLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
            self.midleLine = middleLine;
            [self addSubview:middleLine];
        }
        
        UIView *topLine = [[UIView alloc] init];
        topLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.topLine = topLine;
        [self addSubview:topLine];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat lineW = 1.0;
    self.topLine.frame = CGRectMake(0, 0, self.width, lineW);
    if(_confirmBtn && _cancleBtn){
        _midleLine.frame = CGRectMake(self.width*0.5, lineW, lineW, self.height - lineW);
        _confirmBtn.frame = CGRectMake(0, lineW, self.width*0.5, self.height - 1.0);
        _cancleBtn.frame = CGRectMake(CGRectGetMaxX(self.confirmBtn.frame), self.confirmBtn.y, self.confirmBtn.width, self.confirmBtn.height);
    }else{
        if(_confirmBtn){
            _confirmBtn.frame = CGRectMake(0, lineW, self.width, self.height - lineW);
        }else{
           _cancleBtn.frame = CGRectMake(0, lineW, self.width, self.height - lineW);
        }
    }
    
   
}

-(void)confirm{
    if ([self.delegate respondsToSelector:@selector(bottomViewDidConfirm:)]) {
        [self.delegate bottomViewDidConfirm:self];
    }
}
-(void)cancle{
    if ([self.delegate respondsToSelector:@selector(bottomViewDidCancel:)]) {
        [self.delegate bottomViewDidCancel:self];
    }
}
@end
