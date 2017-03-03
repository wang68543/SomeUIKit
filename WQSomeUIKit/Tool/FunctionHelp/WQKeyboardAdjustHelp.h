//
//  WQKeyboardManager.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/2/28.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef UIView<UITextInput> WQTextFiledView;
typedef NS_ENUM(NSInteger,TextType) {
    TextTypeFiled,
    TextTypeView
};
@protocol WQKeyboardAdjustDelegate <NSObject>
@optional
-(void)keyboardAdjustShouldNext:(WQTextFiledView *)textFiledView textType:(TextType)textType content:(NSString *)content;
-(void)keyboardAdjustShouldDone:(WQTextFiledView *)textFiledView textType:(TextType)textType content:(NSString *)content;

@end

@interface WQKeyboardAdjustHelp : NSObject


/**
 初始化键盘弹出时页面的辅助工具(需要在界面所有的输入框都被加入到父View之后在初始化)

 @param view 需要根据键盘弹出进行调整的view
 @param excludeTag 当输入框的tag >= 此值的时候 不弹出键盘 为NSNotFound的时候 表示此界面没有不弹出键盘的输入款
 @return view需要Strong此工具
 */
+(instancetype)keyboardAdjustHelpWithView:(UIView *)view excludeTag:(NSInteger)excludeTag;

@property (weak ,nonatomic) id<WQKeyboardAdjustDelegate> delegate;

/**点击背景收回键盘*/
@property (assign ,nonatomic) BOOL enableBackgroundTap;
/**键盘距离输入框的距离*/
@property(nonatomic, assign) CGFloat keyboardDistanceFromTextField;

/** To save keyboard animation duration. */
@property(nonatomic, assign) CGFloat    animationDuration;

/** To mimic the keyboard animation */
@property(nonatomic, assign) NSInteger  animationCurve;
@end
