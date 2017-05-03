//
//  WQPresentationController.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/5/1.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <UIKit/UIKit.h>


// MARK:-------- 使用此类 必须强引用
@interface WQPresentationController : UIPresentationController<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>
/** 弹出页面是否是将要显示 */
@property (assign ,nonatomic,readonly,getter=isPresent) BOOL present;

/** 动画时间 默认0.3 */
@property (assign ,nonatomic) CGFloat duration;

@end
