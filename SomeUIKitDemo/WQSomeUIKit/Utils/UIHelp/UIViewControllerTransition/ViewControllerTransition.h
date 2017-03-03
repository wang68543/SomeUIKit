//
//  BottomTransition.h
//  SomeUIKit
//
//  Created by WangQiang on 2016/11/1.
//  Copyright © 2016年 WangQiang. All rights reserved.
//  从底部往上动画

#import <Foundation/Foundation.h>
//最开始present出来的View上的一个子View的动画类型(类似弹框的效果)
typedef NS_ENUM(NSInteger ,ShowOneSubViewType) {
    ShowOneSubviewTypeDefault,//缺省状态下启用两个View之间转场(ShowSuperViewType)
    ShowOneSubviewFromDownToBottom,
    ShowOneSubviewFromDownToMiddleCenter,
    ShowOneSubviewFromTopToMiddleCenter,
    ShowOneSubviewMiddleCenterFlipTopToDown,
    ShowOneSubviewTypeCustom,
};
typedef NS_ENUM(NSInteger,ShowSuperViewType) {
    ShowSuperViewTypeDefault,
    ShowSuperViewTypePush,
    ShowSuperViewTypePop,
    ShowSuperViewTypeTabRight,
    ShowSuperViewTypeTabLeft,
    ShowSuperViewTypePresentation,
    ShowSuperViewTypeDismissal,
};
typedef NS_ENUM(NSInteger ,AnimationType) {
    AnimationTypeNormal,
    AnimationTypeSpring,
    
    //以下只有当ShowType为Custom才起作用 DEBUG中
    AnimationTypeBlipBounce = 20,//中间位置弹开
    
};

// MARK:-------- 使用此类 必须强引用
@interface ViewControllerTransition : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>

/**动画时间 默认0.3*/
@property (assign ,nonatomic) CGFloat duration;

//====================转场的场景选择========================
/**设置两个View之间的转场*/
@property (assign ,nonatomic) ShowSuperViewType showSuperViewType;
/**设置要Presentation的子View的动画 当设置为Custom就会按照下面的预设的值进行动画 */
@property (assign ,nonatomic) ShowOneSubViewType showOneSubViewType;
//******************************************

#pragma mark -- init
//============tabBarController支持左右滑动初始化方式===============
+(nonnull instancetype)transitionWithTabBarController:(nonnull UITabBarController *)tabBarController;
//******************************************

//============子View转场初始化方式===============
+(nonnull instancetype)transitionWithAnimatedView:(nullable UIView *)animatedView;
//******************************************



//==========ShowOneSubviewTypeCustom 辅助属性==============
/**
 起始需要动画的子View初始Frame
 */
@property (assign ,nonatomic) CGRect orignalFrame;
/**
 子View动画的目标Frame
 */
@property (assign ,nonatomic) CGRect targetFrame;

/**
 背景View的初始颜色
 */
@property (nullable,strong ,nonatomic) UIColor *origanlBackColor;

/**
 背景View动画过后的颜色
 */
@property (strong ,nonatomic,nullable) UIColor *targetBackColor;
//******************************************


/**
 动画类型 (暂时只是子View动画支持)
 */
@property (assign ,nonatomic) AnimationType animationType;
@end
