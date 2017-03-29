//
//  CommonAlertViewController.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/11/2.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "WQAlertController.h"

//#import "WQConstans.h"
#import "APPHELP.h"
#define APP_WIDTH [[UIScreen mainScreen] bounds].size.width
#define APP_HEIGHT [[UIScreen mainScreen] bounds].size.height

#pragma mark ============BottomView=================
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
            confirm.titleLabel.font = [UIFont systemFontOfSize:17.0];
            [confirm setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [confirm setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
            [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
            confirm.backgroundColor = [UIColor clearColor];
           _confirmBtn = confirm;
            [self addSubview:confirm];
        }
        if(cancelTitle || (!cancelTitle && !confirmTitle)){
            if(!cancelTitle) cancelTitle = @"取消";
            UIButton *cancle = [[UIButton alloc] init];
            [cancle setTitle:cancelTitle forState:UIControlStateNormal];
            [cancle setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [cancle addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
            cancle.titleLabel.font = [UIFont systemFontOfSize:16.0];
            cancle.backgroundColor = [UIColor clearColor];
            [cancle setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
            _cancleBtn = cancle;
            [self addSubview:cancle];
        }
        
        if(cancelTitle && confirmTitle){
            UIView *middleLine = [[UIView alloc] init];
            middleLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
           _midleLine = middleLine;
            [self addSubview:middleLine];
        }
        
        UIView *topLine = [[UIView alloc] init];
        topLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _topLine = topLine;
        [self addSubview:topLine];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}
-(void)setTintColor:(UIColor *)tintColor{
    [super setTintColor:tintColor];
    self.midleLine.backgroundColor = tintColor;
    self.topLine.backgroundColor = tintColor;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat lineW = 1.0;
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    CGFloat viewHeight = CGRectGetHeight(self.frame);
    self.topLine.frame = CGRectMake(0, 0, viewWidth, lineW);
    if(_confirmBtn && _cancleBtn){
        _midleLine.frame = CGRectMake(viewWidth*0.5, lineW, lineW, viewHeight - lineW);
        _confirmBtn.frame = CGRectMake(0, lineW, viewWidth*0.5, viewHeight - 1.0);
        _cancleBtn.frame = CGRectMake(CGRectGetMaxX(self.confirmBtn.frame), CGRectGetMinY(self.confirmBtn.frame),  CGRectGetWidth(self.confirmBtn.frame),  CGRectGetHeight(self.confirmBtn.frame));
    }else{
        if(_confirmBtn){
            _confirmBtn.frame = CGRectMake(0, lineW, viewWidth,viewHeight - lineW);
        }else{
            _cancleBtn.frame = CGRectMake(0, lineW, viewWidth, viewHeight - lineW);
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

#pragma mark =============TitleView================
@implementation AlertTitleView

-(instancetype)init{
    if(self = [super init]){
        UIImageView *imageView = [[UIImageView alloc] init];
        
        _iconView = imageView;
        [self addSubview:imageView];
        UILabel  *label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.textColor = [UIColor colorWithRed:157.0/255.0 green:160.0/255.0 blue:166.0/255.0 alpha:1.0];
        _titleLabel = label;
        [self addSubview:label];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _lineView = lineView;
        [self addSubview:lineView];
    }
    return self;
}
+(instancetype)titleView{
    return [[self alloc] init];
}
-(void)setTintColor:(UIColor *)tintColor{
    [super setTintColor:tintColor];
    self.titleLabel.textColor = tintColor;
    self.lineView.backgroundColor = tintColor;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.lineView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 2.0, CGRectGetWidth(self.frame), 2.0);
    CGFloat leftX = 10.0;
    
    if(_iconView.image){
        CGSize imageSize = _iconView.image.size;
        CGFloat imageH = MIN(CGRectGetHeight(self.frame) - CGRectGetHeight(self.lineView.frame), imageSize.height);
        CGFloat imageY = (CGRectGetHeight(self.frame) - CGRectGetHeight(self.lineView.frame) - imageH)*0.5;
        _iconView.frame = CGRectMake(leftX, imageY, imageSize.width, imageH);
        leftX = CGRectGetMaxX(_iconView.frame)+10.0;
    }
    
    if(_titleLabel.text){
        _titleLabel.frame = CGRectMake(leftX, 0.0, CGRectGetWidth(self.frame) - leftX - 20.0, CGRectGetHeight(self.frame) - CGRectGetHeight(self.lineView.frame));
    }
}
@end
#pragma mark =============AlertController================
@interface WQAlertController ()<AlertBottomViewDelegate,UIGestureRecognizerDelegate>{
    NSMutableDictionary *_actions;
    UITapGestureRecognizer *_tapBackGR;
}
@property (strong ,nonatomic) UIView *containerView;
@property (strong ,nonatomic) WQControllerTransition *bottomTranstion;
@end

@implementation WQAlertController

-(UIView *)containerView{
    if(!_containerView){
        _containerView = [[UIView alloc] init];
        
    }
    return _containerView;
}
+(instancetype)alertViewWithTitle:(NSString *)title centerView:(UIView *)centerView{
    return [[self alloc] initWithTitle:title titleIcon:nil centerView:centerView confirmTitle:@"确定" cancelTitle:@"取消"];
}
+(instancetype)alertViewWithIcon:(NSString *)titleIcon centerView:(UIView *)centerView{
    return [[self alloc] initWithTitle:nil titleIcon:titleIcon centerView:centerView confirmTitle:@"确定" cancelTitle:@"取消"];
}
+(instancetype)alertWithCenterView:(UIView *)centerView{
    return [self alertWithCenterView:centerView isNeedBottomView:YES];
}
+(nonnull instancetype)alertWithCenterView:(nonnull UIView *)centerView isNeedBottomView:(BOOL)needBottom{
    NSString *confirmTitle;
    NSString *cancelTitle;
    if(needBottom){
        confirmTitle = @"确定";
        cancelTitle = @"取消";
    }
    return [[self alloc] initWithTitle:nil titleIcon:nil centerView:centerView confirmTitle:confirmTitle cancelTitle:cancelTitle];
}
+(instancetype)alertViewWithTitle:(NSString *)title titleIcon:(NSString *)titleIcon centerView:(UIView *)centerView confirmTitle:(NSString *)confirmitle cancelTitle:(NSString *)cancelTitle{
    return [[self alloc] initWithTitle:title titleIcon:titleIcon centerView:centerView confirmTitle:@"确定" cancelTitle:@"取消"];
}
+(instancetype)alertWithContent:(NSString *)content{
    
    return [self alertWithContent:content title:nil];
}

+(instancetype)alertWithContent:(NSString *)content title:(NSString *)title{
    if(!content || content.length <= 0) return nil;
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = content;
    contentLabel.numberOfLines = 0;
    UIEdgeInsets _contentEdge = UIEdgeInsetsMake(15, 15, 15, 15);
    CGFloat contentWidth = AlertCenterWidth - _contentEdge.left - _contentEdge.right;
    UIFont *contentFont = [UIFont systemFontOfSize:17.0];
    
    CGSize contentSize = [contentLabel.text boundingRectWithSize:CGSizeMake(contentWidth, APP_HEIGHT - 280) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :contentFont} context:nil].size;
    contentLabel.frame = (CGRect){CGPointMake(_contentEdge.left, _contentEdge.top),contentSize};
    UIView *centerView = [[UIView alloc] init];
    centerView.backgroundColor = [UIColor clearColor];
    centerView.bounds = CGRectMake(0, 0, AlertCenterWidth, contentSize.height + _contentEdge.top + _contentEdge.bottom);
    [centerView addSubview:contentLabel];
    return [self alertViewWithTitle:title centerView:centerView];
}

-(instancetype)initWithTitle:(nullable NSString *)title
                   titleIcon:(nullable NSString *)titleIcon
                  centerView:(nonnull UIView *)centerView
                confirmTitle:(nullable NSString *)confirmitle
                 cancelTitle:(nullable NSString *)cancelTitle{
    if (self = [super init]){
        _actions = [NSMutableDictionary dictionary];
        _centerViews = [NSMutableArray array];
        
        [self configTitleViewWithTitle:title icon:titleIcon];
        [self configCenterView:centerView];
        
        [self configBottomViewWithConfirm:confirmitle cancel:cancelTitle];
        [self layoutContainerSubView];
        
        
        [_centerViews addObject:_topCenterView];
//        self.containerViewRadius = 5.0;
    }
    return self;
}
#pragma mark -- 配置标题视图
-(void)configTitleViewWithTitle:(NSString *)title icon:(NSString *)titileIcon{
    if(_titleView)[_titleView removeFromSuperview];
    if(title || titileIcon){
        _titleView = [AlertTitleView titleView];
        
        _titleView.titleLabel.text = title;
        _titleView.iconView.image = [UIImage imageNamed:titileIcon];
        
        [self.containerView addSubview:_titleView];
    }else{
        _titleView = nil;
    }
}
-(void)setContainerViewRadius:(CGFloat)containerViewRadius{
    if(containerViewRadius < 0) containerViewRadius = 0 ;
    if(containerViewRadius != _containerViewRadius){
        _containerViewRadius = containerViewRadius;
        self.containerView.layer.cornerRadius = _containerViewRadius;
        self.containerView.layer.masksToBounds = YES;
    }
}
#pragma mark -- 配置底部视图
-(void)configBottomViewWithConfirm:(NSString *)confirmTitle cancel:(NSString *)cancelTitle{
    if(_bottomView){
        [_bottomView removeFromSuperview];
    }
    if(confirmTitle || cancelTitle){
        _bottomView = [AlertBottomView bottomViewWithConfirmTitle:confirmTitle cacelTitle:cancelTitle];
        _bottomView.delegate = self;
        [self.containerView addSubview:self.bottomView];
   
    }else{
        _bottomView = nil;
        [self configTapGR];
    }
}
#pragma mark -- 配置中间视图
-(void)configCenterView:(UIView *)centerView{
    if(_topCenterView)[_topCenterView removeFromSuperview];
    _topCenterView = centerView;
    UIView *tf = [self findInputText:centerView];
    if(tf){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    [self configTapGR];
    [self.containerView addSubview:centerView];
}
#pragma mark -- 配置点击的手势
-(void)configTapGR{
    if(!_bottomView){
        if(!_tapBackGR){
            _tapBackGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBack:)];
            _tapBackGR.delegate = self;
            [self.view addGestureRecognizer:_tapBackGR];
        }
    }else{
        UIView *tf = [self findInputText:_topCenterView];
        if(tf&&!_tapBackGR){
            _tapBackGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBack:)];
            _tapBackGR.delegate = self;
            [self.view addGestureRecognizer:_tapBackGR];
        }
    }
   
}
#pragma mark -- 设置主体颜色
-(void)setTintColor:(UIColor *)tintColor{
    if(!tintColor)return;
    _tintColor = tintColor;
    _titleView.tintColor = tintColor;
    _bottomView.tintColor = tintColor;
}
-(void)layoutContainerSubView{
    CGFloat centerViewHeight = 0.0;
    CGFloat centerViewWidth = MIN(CGRectGetWidth(_topCenterView.frame), AlertCenterWidth);
    if(_titleView){
        _titleView.frame = CGRectMake(0, 0, centerViewWidth, 49.0);
        centerViewHeight += 49.0;
    }
    
    CGRect _topCenterViewFrame = CGRectMake(MAX(0, (centerViewWidth - CGRectGetWidth(_topCenterView.frame))*0.5), centerViewHeight, CGRectGetWidth(_topCenterView.frame), CGRectGetHeight(_topCenterView.frame));
 
    _topCenterView.frame = _topCenterViewFrame;

    centerViewHeight += _topCenterViewFrame.size.height;
    
    if(_bottomView){
        _bottomView.frame = CGRectMake(0, centerViewHeight, centerViewWidth, 49.0);
        centerViewHeight += 49.0;
    }

    _containerView.frame = CGRectMake((APP_WIDTH - centerViewWidth)*0.5,( APP_HEIGHT - centerViewHeight)*0.5, centerViewWidth, centerViewHeight);
}
-(UIView *)findInputText:(UIView *)findView{
    if ([findView conformsToProtocol:@protocol(UITextInput)]) {
        return findView;
    }
    for (UIView *subview in findView.subviews) {
        UIView *tf = [self findInputText:subview];
        if (tf) {
            return tf;
        }
    }
    return nil;
}
-(UIView *)findFirstResponderInputText:(UIView *)findView{
    if ([findView conformsToProtocol:@protocol(UITextInput)] && findView.isFirstResponder) {
        return findView;
    }
    for (UIView *subview in findView.subviews) {
        UIView *tf = [self findFirstResponderInputText:subview];
        if (tf) {
            return tf;
        }
    }
    return nil;
}
-(void)dealloc{
      NSLog(@"弹出框销毁了");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)keyboardWillChangeFrame:(NSNotification *)note{
  
    // 取出键盘高度
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIView *tf = [self findFirstResponderInputText:_topCenterView];
    if(!tf){
        [UIView animateWithDuration:duration animations:^{
            self.containerView.transform = CGAffineTransformIdentity;
        }];
        return;
    }
    //将原本在sv_bg得Rect改为self.view.window上的Rect
    CGRect kuangToViewframe  = [tf.superview convertRect:tf.frame toView:nil];
    
    //[self.view convertRect:tf.frame fromView:tf];
    //框的最大Y值大于键盘的最小y值 急这两者就交叉了
    CGFloat offsetY = CGRectGetMaxY(kuangToViewframe) - keyboardF.origin.y;
    if (offsetY > 0) {//交叉了,需要往上移
        [UIView animateWithDuration:duration animations:^{
            self.containerView.transform = CGAffineTransformMakeTranslation(0, -offsetY - 10.0);
        }];
    }else{
        [UIView animateWithDuration:duration animations:^{
            self.containerView.transform = CGAffineTransformIdentity;
        }];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];
}

-(void)showInViewController:(UIViewController *)inViewController{
    [self showInViewController:inViewController subViewFrameChangeType:ShowOneSubviewFromDownToMiddleCenter subViewShowAnimationType:AnimationTypeSpring];
}
-(void)showInViewController:(UIViewController *)inViewController subViewFrameChangeType:(ShowOneSubViewType)showSubViewType subViewShowAnimationType:(AnimationType)animationTye{
    if(!inViewController){
        inViewController = [APPHELP visibleViewController];
    }
    _bottomTranstion = [WQControllerTransition transitionWithAnimatedView:self.containerView];
    _bottomTranstion.showOneSubViewType = showSubViewType;
    _bottomTranstion.animationType = animationTye;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.transitioningDelegate = _bottomTranstion;
    // MARK: -- 非自定义翻页的半透明效果
    /**如果不自定义翻页效果 设置下面这个属性可以有半透明的效果
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];*/
    //    self.modalTransitionStyle 系统的翻页效果
    self.modalPresentationStyle = UIModalPresentationCustom;
    [inViewController presentViewController:self animated:YES completion:NULL];
}
#pragma amrk -- AlertBottomViewDelegate
-(void)bottomViewDidCancel:(AlertBottomView *)bottomView{
//    if([self.delegate respondsToSelector:@selector(commonAlertDidCancel:)]){
//        [self.delegate commonAlertDidCancel:self];
//    }else{
//     [self dismissViewControllerAnimated:YES completion:NULL];
//    }
    BottomAction block = [_actions valueForKey:ActionCancel];
    if(block){
      block(self);
    }else{
       [self dismissViewControllerAnimated:YES completion:NULL]; 
    }
}

-(void)bottomViewDidConfirm:(AlertBottomView *)bottomView{
//    if([self.delegate respondsToSelector:@selector(commonAlertDidConfirm:)]){
//        [self.delegate commonAlertDidConfirm:self];
//    }
    BottomAction block = [_actions valueForKey:ActionConfirm];
//    __weak typeof(self) weakSelf = self;
    if(block) {
        block(self);
    }else{
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
#pragma mark -- tap Action
-(void)tapBack:(UITapGestureRecognizer *)tapGR{
    UIView *tf =  [self findFirstResponderInputText:self.containerView];
    if(tf){
        [tf resignFirstResponder];
    }else{
        if(!_bottomView){//有底部视图就把具体的消失动作交给底部视图
           [self dismissViewControllerAnimated:YES completion:NULL];
        }
    }
}
#pragma mark -- -UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint point = [gestureRecognizer locationInView:self.view];
    if(CGRectContainsPoint(self.containerView.frame, point)){
        return NO;
    }else{
        return YES;
    }
}
-(void)pushCenterView:(UIView *)centerView animate:(BOOL)animate{
    //这里 centerView 在创建的时候最好设置Frame 不要设置bounds 不然在动画的过程中可能显示不全
    if(!animate){
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [self.view endEditing:YES];
        [self configCenterView:centerView];
        [_centerViews addObject:centerView];
        [self layoutContainerSubView];
        [CATransaction commit];
    }else{
        __weak typeof(self) weakSelf = self;
        [UIView transitionWithView:_containerView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            [weakSelf.view endEditing:YES];
            [weakSelf configCenterView:centerView];
            [weakSelf layoutContainerSubView];
        } completion:^(BOOL finished) {
            [_centerViews addObject:centerView];
        }];
    }
   
}
-(void)popCenterViewAnimate:(BOOL)animate{
    if([_centerViews count] <= 1){
        //这个易造成死循环
//        if(_bottomView){
//            [self bottomViewDidCancel:_bottomView];
//        }else{
            [self dismissViewControllerAnimated:animate completion:NULL];
//        }
    }else{
      
        if(!animate){
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            UIView *centerView = [_centerViews objectAtIndex:_centerViews.count - 2];
            [self configCenterView:centerView];
            [_centerViews removeLastObject];
            [self layoutContainerSubView];
            [CATransaction commit];
        }else{
            __weak typeof(self) weakSelf = self;
            [UIView transitionWithView:_containerView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                UIView *centerView = [_centerViews objectAtIndex:_centerViews.count - 2];
                [weakSelf configCenterView:centerView];
                [_centerViews removeLastObject];
                [weakSelf layoutContainerSubView];
            } completion:NULL];
        }

    }
}
-(void)addActionType:(NSString *const)type action:(BottomAction)action{
    //如果是__NSStackBlock__这里会自动copy一份到堆上__NSMallocBlock__的当传值给字典的时候
    [_actions setValue:action forKey:type];
}
 NSString *const ActionConfirm = @"Confirm";
 NSString *const ActionCancel = @"Cancel";

@end

