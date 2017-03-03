//
//  BottomTransition.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/11/1.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "ViewControllerTransition.h"
@interface ViewControllerTransition()<UITabBarControllerDelegate>
@property (weak ,nonatomic) UIView *animatedView;
@property (assign ,nonatomic) BOOL interactive;
@property (strong ,nonatomic) UIPercentDrivenInteractiveTransition *interactionController;
@property (weak ,nonatomic) UITabBarController *tabBarController;
@end
@implementation ViewControllerTransition
#pragma mark -- 子View转场初始化方式
+(nonnull instancetype)transitionWithAnimatedView:(nullable UIView *)animatedView{
    return [[self alloc] initTransitionWithAnimatedView:animatedView];
}
-(instancetype)initTransitionWithAnimatedView:(nullable UIView *)animatedView{
    if(self = [super init]){
        self.animatedView = animatedView;
        [self defaultOneSubViewInit];
    }
    return self;
}
#pragma mark -- tabBarController支持左右滑动初始化方式
+(instancetype)transitionWithTabBarController:(UITabBarController *)tabBarController{
    NSAssert([tabBarController isKindOfClass:[UITabBarController class]], @"此方法只支持TabBarController初始化");
    return [[self alloc] initTransitionWithTabBarController:tabBarController];
}
-(instancetype)initTransitionWithTabBarController:(UITabBarController *)tabBarController{
    if(self = [super init]){
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [tabBarController.view addGestureRecognizer:panGR];
        tabBarController.delegate = self;
        self.tabBarController = tabBarController;
        [self defaultSuperViewInit];
    }
    return self;
}
-(instancetype)init{
    if(self = [super init]){
        [self defaultOneSubViewInit];
    }
    return self;
}
-(void)defaultSuperViewInit{
    _showOneSubViewType = ShowOneSubviewTypeDefault;
    _duration = 0.3;
    [self defaultCommonInit];
}
-(void)defaultOneSubViewInit{
    _showOneSubViewType = ShowOneSubviewFromDownToBottom;
    _animationType = AnimationTypeNormal;
    _showSuperViewType = ShowSuperViewTypeDefault;
    _duration = 0.5;
    [self defaultCommonInit];
}
-(void)defaultCommonInit{
    
}
#pragma mark -- ViewController Transitioning Delegate
// MARK: - UIViewControllerTransitioningDelegate
// 该方法用于返回一个负责转场动画的对象
// 可以在该对象中控制弹出视图的尺寸等

//这里下面可以自定义一个类 遵守UIViewControllerAnimatedTransitioning协议可以在其中实现UIViewControllerInteractiveTransitioning协议的方法进行自定义动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}


#pragma mark -- ViewController Interactive Transitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return self.duration;
}
#pragma mark -- TabBarController  Delegate
// MARK: 这里参考的 http://chuansong.me/n/2672777  
- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController{
    return self.interactive? _interactionController:nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC{
    NSInteger fromIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSInteger toIndex = [tabBarController.viewControllers indexOfObject:toVC];
    _showSuperViewType = toIndex < fromIndex ? ShowSuperViewTypeTabLeft:ShowSuperViewTypeTabRight;
    return self;
}
#pragma mark -- 控制器的View只有一个子View的时候 使用这个动画 只动画子view的frame跟父View的的背景色
-(void)animationOneSubView:(id <UIViewControllerContextTransitioning>)transitionContext{
   //viewForKey:方法返回 nil 只有一种情况：  UIModalPresentationCustom 模式下的 Modal 转场 ，通过此方法获取 presentingView 时得到的将是 nil
    //UIModalPresentationCustom 这种模式下的 Modal 转场结束时 fromView 并未从视图结构中移除 UIModalPresentationFullScreen 模式的 Modal 转场结束后 fromView 依然主动被从视图结构中移除了
    
    //iOS8 协议添加了viewForKey:方法以方便获取 fromView 和 toView，但是在 Modal 转场里要注意，从上面可以知道，Custom 模式下，presentingView 并不受 containerView 管理，这时通过viewForKey:方法来获取 presentingView 得到的是 nil，必须通过viewControllerForKey:得到 presentingVC 后来获取。因此在 Modal 转场中，较稳妥的方法是从 fromVC 和 toVC 中获取 fromView 和 toView。
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIColor *viewBackColor ;
    //    CGAffineTransform  transform;

    if(!self.animatedView) self.animatedView = [toView.subviews firstObject];
    CGRect targetFrame = self.animatedView.frame;
    
    if(toView){//显示动画
        CGRect orignalFrame = self.animatedView.frame;
        UIView *containerView = [transitionContext containerView];
        [containerView addSubview:toView];
        viewBackColor =  self.targetBackColor ?self.targetBackColor:[[UIColor blackColor] colorWithAlphaComponent:0.5];
        //        transform = CGAffineTransformMakeTranslation(0, -self.actionSheetView.height);
        
        switch (_showOneSubViewType) {
            case ShowOneSubviewFromDownToBottom:
                orignalFrame.origin.y = toView.frame.size.height;
                targetFrame.origin.y = toView.frame.size.height - targetFrame.size.height;
                break;
            case ShowOneSubviewFromDownToMiddleCenter:
                orignalFrame.origin.y = toView.frame.size.height;
                
                targetFrame.origin.y = toView.center.y - targetFrame.size.height*0.5;
                targetFrame.origin.x = (CGRectGetWidth(toView.frame) - CGRectGetWidth(orignalFrame))*0.5;
                break;
            case ShowOneSubviewFromTopToMiddleCenter:
                orignalFrame.origin.y = -orignalFrame.size.height;
                
                targetFrame.origin.y = toView.center.y - targetFrame.size.height*0.5;
                targetFrame.origin.x = (CGRectGetWidth(toView.frame) - CGRectGetWidth(orignalFrame))*0.5;
                break;
            case ShowOneSubviewMiddleCenterFlipTopToDown:
                orignalFrame.origin.y = -orignalFrame.size.height;
                
                targetFrame.origin.y = toView.center.y - targetFrame.size.height*0.5;
                targetFrame.origin.x = (CGRectGetWidth(toView.frame) - CGRectGetWidth(orignalFrame))*0.5;
                break;
            case ShowOneSubviewTypeCustom:
                orignalFrame = CGRectIsEmpty(self.orignalFrame)?self.animatedView.frame:self.orignalFrame;
                //先弄一个默认的位置(默认显示在底部) 以防目标frame为空
                targetFrame.origin.y = toView.frame.size.height - targetFrame.size.height;
                targetFrame = CGRectIsEmpty(self.targetFrame)?targetFrame:self.targetFrame;
                break;
                
            default:
                break;
        }
        //预设好动画的初始状态
        toView.backgroundColor = self.origanlBackColor ? self.origanlBackColor:[UIColor clearColor];
        //        toView.backgroundColor = viewBackColor;
        self.animatedView.frame = orignalFrame;//先摆好要动画的View的位置
    }else{//消失动画
        toView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        viewBackColor = self.origanlBackColor?self.origanlBackColor:[UIColor clearColor];
        //        transform = CGAffineTransformIdentity;
        
        //回到初始的值
        
        switch (_showOneSubViewType) {
            case ShowOneSubviewFromDownToBottom:
                targetFrame.origin.y = toView.frame.size.height;
                break;
            case ShowOneSubviewFromDownToMiddleCenter:
                targetFrame.origin.y = toView.frame.size.height;
                break;
            case ShowOneSubviewFromTopToMiddleCenter:
                targetFrame.origin.y = -targetFrame.size.height;
                break;
            case ShowOneSubviewMiddleCenterFlipTopToDown:
                targetFrame.origin.y = toView.frame.size.height;
                break;
            case ShowOneSubviewTypeCustom:
                targetFrame.origin.y = toView.frame.size.height;
                targetFrame = CGRectIsEmpty(self.orignalFrame)?targetFrame:self.orignalFrame;
                break;
            default:
                targetFrame = CGRectZero;
                break;
        }
        
    }
    __weak typeof(self) weakSelf = self;
    
    //先预设初始的frame
    if(_animationType == AnimationTypeSpring){
        /**
         *  usingSpringWithDamping 范围为0.0f到1.0f，数值越小「弹簧」的振动效果越明显
         *  initialSpringVelocity 则表示初始的速度，数值越大一开始移动越快 值得注意的是，初始速度取值较高而时间较短时，也会出现反弹情况。
         */
        dispatch_block_t backColorAnimation = ^{
            toView.backgroundColor = viewBackColor;
        };
        
        [self normalAnmiation:backColorAnimation transitionContext:nil];
        dispatch_block_t subViewFrameAnimation = ^{
            if(weakSelf.animatedView){
                weakSelf.animatedView.frame = targetFrame;
            }
        };
        [self springAnimation:subViewFrameAnimation damping:0.5 velocity:3.0 transitionContext:transitionContext];
        
        //        _animationType = AnimationTypeNormal;//这里 暂时设置显示的时候Spring动画  消失的时候回归正常动画 解决 spring消失动画闪现黑屏问题
    }else if(_animationType == AnimationTypeBlipBounce){
        
    }else{
        dispatch_block_t anmation = ^{
            if(weakSelf.animatedView){
                weakSelf.animatedView.frame = targetFrame;
            }
            toView.backgroundColor = viewBackColor;
        };
        
        [self normalAnmiation:anmation transitionContext:transitionContext];
    }
}

#pragma mark -- 动画类型 有context就需要结束通知上下文
-(void)normalAnmiation:(dispatch_block_t)anmtionBlock transitionContext:(id <UIViewControllerContextTransitioning>)context{
    [UIView animateWithDuration:self.duration animations:anmtionBlock completion:^(BOOL finished) {
        if(context){
          [context completeTransition:![context transitionWasCancelled]];
        }
    }];
}

-(void)springAnimation:(dispatch_block_t)anmtionBlock damping:(CGFloat)damping velocity:(CGFloat)velocity transitionContext:(id <UIViewControllerContextTransitioning>)context{
    [UIView animateWithDuration:self.duration delay:0.0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionCurveEaseInOut animations:anmtionBlock completion:^(BOOL finished) {
        if(context)[context completeTransition:![context transitionWasCancelled]];
    }];
}

/* 过渡效果
 fade     //交叉淡化过渡(不支持过渡方向)
 push     //新视图把旧视图推出去
 moveIn   //新视图移到旧视图上面
 reveal   //将旧视图移开,显示下面的新视图
 cube     //立方体翻滚效果
 oglFlip  //上下左右翻转效果
 suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
 rippleEffect //滴水效果(不支持过渡方向)
 pageCurl     //向上翻页效果
 pageUnCurl   //向下翻页效果
 cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
 cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
 */

/* 过渡方向
 fromRight;
 fromLeft;
 fromTop;
 fromBottom;
 */


/** *********push的时候自定义动画效果***********
 CATransition *animation = [CATransition animation];
 [animation setDuration:0.5];
 [animation setType: kCATransitionPush];
 [animation setSubtype:kCATransitionFromTop];//从上推入
 [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
 [self  pushViewController:aViewController animated:NO];
 [self .view.layer addAnimation:animation forKey:nil];
 
 ** ***********present的时候自定义动画效果********************
 CATransition *animation = [CATransition animation];
 animation.duration = 1.0;
 animation.timingFunction = UIViewAnimationCurveEaseInOut;
 animation.type = @"pageCurl";
 //animation.type = kCATransitionPush;
 animation.subtype = kCATransitionFromLeft;
 [self.view.window.layer addAnimation:animation forKey:nil];
 [self presentModalViewController:myNextViewController animated:NO completion:nil];
 */
/*
 Transition   	                   Subtypes	             Accepted parameters
 moveIn/push/reveal	fromLeft,fromRight,fromBottom,fromTop	      -
 pageCurl/pageUnCur fromLeft, fromRight, fromTop, fromBottom	float inputColor[];
 cube/alignedCube	fromLeft, fromRight, fromTop, fromBottom	float inputAmount; (perspective)
 flip/alignedFlip/oglFlip	fromLeft, fromRight, fromTop, fromBottom	float inputAmount;
 cameraIris	                         -	               CGPoint inputPosition;
 rippleEffect	                     -	                           -
 rotate	                 90cw, 90ccw, 180cw, 180ccw	               -
 suckEffect	                         -	              CGPoint inputPosition;
 */
//-(void)transition:(id <UIViewControllerContextTransitioning>)transitionContext{
//    
//    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    UIColor *viewBackColor ;
//    //    CGAffineTransform  transform;
//    
//    if(!self.animatedView) self.animatedView = [toView.subviews firstObject];
//    CGRect targetFrame = self.animatedView.frame;
//    
//    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//    
//    if(toView){
//        self.animatedView.center =  toView.center;
//        
//       
//    }
//
//  [UIView transitionWithView:fromView duration:self.duration options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//      toView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//      UIView *containerView = [transitionContext containerView];
//       [containerView addSubview:toView];
////      toView.backgroundColor = [UIColor redColor];
//      
//  } completion:^(BOOL finished) {
//      [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//  }];
////
////    
////
////    
////    CATransition *animation = [CATransition animation];
////    
////    [animation setDuration:3.0];
////    
////    [animation setFillMode:kCAFillModeForwards];
////    
////    animation.timingFunction = UIViewAnimationCurveEaseInOut;
////    [animation setType:@"rippleEffect"];// rippleEffect
////    
////    [animation setSubtype:kCATransitionFromTop];
////    animation.startProgress = 0.0; //动画开始起点(在整体动画的百分比)
////    animation.endProgress = 1.0;  //动画停止终点(在整体动画的百分比)
////    animation.removedOnCompletion = NO;
////    [containerView.layer addAnimation:animation forKey:nil];
////    [containerView addSubview:toView];
////    toView.backgroundColor = [UIColor redColor];
////      [transitionContext completeTransition:YES];
////    [containerView addSubview:toView];
////    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
////    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
////    [toViewController transitionFromViewController:fromViewController toViewController:toViewController duration:self.duration options:UIViewAnimationOptionTransitionFlipFromLeft animations:NULL completion:^(BOOL finished) {
////        [transitionContext completeTransition:YES];
////    }];
//    
////    [UIView transitionFromView:[transitionContext viewForKey:UITransitionContextFromViewKey] toView:[transitionContext viewForKey:UITransitionContextToViewKey] duration:self.duration options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
////        [transitionContext completeTransition:YES];
////    }];
////    [UIView transitionWithView:[transitionContext viewForKey:UITransitionContextToViewKey] duration:self.duration options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
////        
////    } completion:^(BOOL finished) {
////        [transitionContext completeTransition:YES];
////    }];
//}
#pragma mark -- 父View的转场动画
-(void)handlePan:(UIPanGestureRecognizer *)panGR{
    CGFloat transLationX = fabs([panGR translationInView:_tabBarController.view].x);
    
//让 View 跟着手指移动 (无跳跃感)
    
//    [panGR setTranslation:CGPointZero inView:panGR.view.superview];
    CGFloat progress = transLationX/_tabBarController.view.frame.size.width;
    switch (panGR.state) {
        case UIGestureRecognizerStateBegan:{
            
            self.interactive = YES;
            CGFloat velocityX = [panGR velocityInView:_tabBarController.view].x;
            if(velocityX < 0){
                if(_tabBarController.selectedIndex < _tabBarController.viewControllers.count -1){
                    _tabBarController.selectedIndex += 1;
                }
            }else{
                if(_tabBarController.selectedIndex > 0 ){
                    _tabBarController.selectedIndex -= 1;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
            //问
            [self.interactionController updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            self.interactionController.completionSpeed = 0.99;
            if(progress > 0.3){
                [self.interactionController finishInteractiveTransition];
            }else{
                //转场取消后，UITabBarController 自动恢复了 selectedIndex 的值，不需要我们手动恢复。
                [self.interactionController cancelInteractiveTransition];
            }
            self.interactive = NO;
            break;
        default:
            break;
    }
}
-(void)animationSuperView:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *contanierView = [transitionContext containerView];
    
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVc.view;
    UIView *toView = toVC.view;
    CGFloat translation = contanierView.frame.size.width;
    
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    
    switch (_showSuperViewType) {
        case ShowSuperViewTypePop:
            translation = -translation;
        case ShowSuperViewTypePush:
            toViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            fromViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            break;
        case ShowSuperViewTypeTabRight:
            translation = -translation;
        case ShowSuperViewTypeTabLeft:
            
            toViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            fromViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            
            break;
        case ShowSuperViewTypePresentation:
            translation =  contanierView.frame.size.height;
            toViewTransform = CGAffineTransformMakeTranslation(0, translation);
            fromViewTransform = CGAffineTransformMakeTranslation(0, 0);
            break;
        case ShowSuperViewTypeDismissal:
            translation =  contanierView.frame.size.height;
            toViewTransform = CGAffineTransformMakeTranslation(0, 0);
            fromViewTransform = CGAffineTransformMakeTranslation(0, translation);
            break;
        default:
            break;
    }
    
    switch (_showSuperViewType) {
        case ShowSuperViewTypeDismissal:
            //在 dismissal 转场中，不要添加 toView，否则黑屏
            break;
        default:
            [contanierView addSubview:toView];
            break;
    }
    
    toView.transform = toViewTransform;
    
    [UIView animateWithDuration:self.duration animations:^{
        fromView.transform = fromViewTransform;
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if(_showSuperViewType == ShowSuperViewTypeDefault){
         [self animationOneSubView:transitionContext];
    }else{
        [self animationSuperView:transitionContext];
    }
   
//    [self transition:transitionContext];
}


@end
