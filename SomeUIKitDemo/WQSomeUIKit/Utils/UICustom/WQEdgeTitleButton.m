//
//  KDBottomTitleButton.m
//  KD_3.0
//
//  Created by WangQiang on 15/10/9.
//  Copyright © 2015年 JunJun. All rights reserved.
//

#import "WQEdgeTitleButton.h"
@interface WQEdgeTitleButton(){
    UIEdgeInsets _edge;
    CGFloat _textPadding;
}
@property (assign ,nonatomic) CGSize titleSize;
@end
@implementation WQEdgeTitleButton
-(instancetype)init{
    if(self = [super init]){
        _edge = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
         _textPadding = 3.0;//文字与图片之间的间距
    }
    return self;
}
/**
 *  设置内部图标的frame 在调这个方法之前会调用-(void)setImage:(UIImage *)image forState:(UIControlState)state
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
//    NSLog(@"%s == %@",__func__,NSStringFromCGRect(contentRect));
    //这里是用来防止图片过大的
    
    BOOL hasImage = [self imageForState:UIControlStateNormal] || [self imageForState:UIControlStateSelected] || [self imageForState:UIControlStateHighlighted];
    
    if(!hasImage){
        return CGRectZero;
    }
    
    BOOL hasText = [self titleForState:UIControlStateNormal] || [self titleForState:UIControlStateSelected] || [self titleForState:UIControlStateHighlighted];
    
    CGFloat imageW ;
    CGFloat imageH ;
    imageW = MIN(self.imageSize.width, contentRect.size.width);
    imageH = MIN(self.imageSize.height, contentRect.size.width);

    
    CGFloat imageY = 0;
    CGFloat imageX = 0;
   
    CGFloat titleH =  self.titleSize.height ;
    CGFloat titleW =  self.titleSize.width;
    
    CGFloat contentH = hasText ? (imageH + titleH + _textPadding):imageH;
    
    switch (self.contentVerticalAlignment) {//垂直
        case UIControlContentVerticalAlignmentTop:
            switch (self.titleAliment) {
                case ButtonTitleAlimentTop:
                    imageY = hasText ? _edge.top+_textPadding+titleH : _edge.top;
                    break;
                case ButtonTitleAlimentLeft:
                case ButtonTitleAlimentBottom:
                case ButtonTitleAlimentRight:
                default:
                     imageY = _edge.top;
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentBottom:
            switch (self.titleAliment) {
                case ButtonTitleAlimentBottom:
                    imageY = contentRect.size.height - contentH - _edge.bottom;
                    break;
                    
                case ButtonTitleAlimentTop:
                case ButtonTitleAlimentLeft:
                case ButtonTitleAlimentRight:
                default:
                    imageY = contentRect.size.height - _edge.bottom - imageH;
                    break;
            }
            break;
            
            
        case UIControlContentVerticalAlignmentFill:
            switch (self.titleAliment) {
                case ButtonTitleAlimentTop:
                    imageY =  contentRect.size.height -(contentRect.size.height - contentH)*0.5 - imageH ;
                    break;
                    
                case ButtonTitleAlimentBottom:
                    imageY = (contentRect.size.height - contentH)*0.5;
                    break;
                case ButtonTitleAlimentLeft:
                case ButtonTitleAlimentRight:
                default:
                    imageY = (contentRect.size.height - imageH)*0.5;
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentCenter:
        default:
            switch (self.titleAliment) {
                case ButtonTitleAlimentTop:
                    imageY =  contentRect.size.height - (contentRect.size.height - contentH)*0.5 - imageH ;
                    break;
                    
                case ButtonTitleAlimentBottom:
                    imageY = (contentRect.size.height - contentH)*0.5;
                    break;
                case ButtonTitleAlimentLeft:
                case ButtonTitleAlimentRight:
                default:
                    imageY = (contentRect.size.height - imageH)*0.5;
                    break;
            }
            break;
    }
//    CGFloat imageCenterX = (contentRect.size.width - titleW)*0.5;
    CGFloat contentW = hasText ? (imageW + titleW + _textPadding):imageW;
    
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentLeft:
            switch (self.titleAliment) {
                case ButtonTitleAlimentLeft:
                    imageX = _edge.left + titleW;
                    break;
                case ButtonTitleAlimentBottom:
                case ButtonTitleAlimentRight:
                case ButtonTitleAlimentTop:
                default:
                    imageX = _edge.left;
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentRight:
            switch (self.titleAliment) {
                case ButtonTitleAlimentRight:
                
                    imageX = contentRect.size.width - contentW -_edge.right;
                    break;
                case ButtonTitleAlimentBottom:
                case ButtonTitleAlimentLeft:
                case ButtonTitleAlimentTop:
                default:
                    imageX = contentRect.size.width - _edge.right - imageW;
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentFill:
            switch (self.titleAliment) {
                case ButtonTitleAlimentLeft:
                    imageX =contentRect.size.width - (contentRect.size.width - contentW) * 0.5 - imageW;
                    break;
                case ButtonTitleAlimentRight:
                    imageX = (contentRect.size.width - contentW) * 0.5 ;
                    break;
                case ButtonTitleAlimentBottom:
                case ButtonTitleAlimentTop:
                default:
                    imageX = (contentRect.size.width - imageW) * 0.5 ;
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentCenter:
        default:
            switch (self.titleAliment) {
                case ButtonTitleAlimentLeft:
                    imageX = (contentRect.size.width - contentW) * 0.5 + titleW +_textPadding;
                    break;
                case ButtonTitleAlimentRight:
                    imageX = (contentRect.size.width - contentW) * 0.5 ;
                    break;
                case ButtonTitleAlimentBottom:
                case ButtonTitleAlimentTop:
                default:
                    imageX = (contentRect.size.width - imageW) * 0.5 ;
                    break;
            }
            break;
    }

 
    return CGRectMake(imageX, imageY, imageW, imageH);
}

/**
 *  设置内部文字的frame 在调这个方法之前会调用- (void)setTitle:(NSString *)title forState:(UIControlState)state
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
//    NSLog(@"%s == %@",__func__,NSStringFromCGRect(contentRect));
    
    //文字的布局依赖于图片的布局完成
    BOOL hasText = [self titleForState:UIControlStateNormal] || [self titleForState:UIControlStateSelected] || [self titleForState:UIControlStateHighlighted];
    
    if(!hasText){
        return CGRectZero;
    }
    
    CGFloat titleY = 0;
    
    CGFloat titleX = 0;
    
    CGFloat titleH = self.titleSize.height;
    
    CGFloat titleW = self.titleSize.width;
    
  
    
    CGRect imageFrame = [self imageRectForContentRect:contentRect];
    //是否有图片
    BOOL hasImage = [self imageForState:UIControlStateNormal] || [self imageForState:UIControlStateSelected] || [self imageForState:UIControlStateHighlighted];
   
    
      CGFloat titleCenterY = (contentRect.size.height - titleH)*0.5;
    
        switch (self.contentVerticalAlignment) {//垂直
            case UIControlContentVerticalAlignmentTop:
                switch (self.titleAliment) {
                    case ButtonTitleAlimentBottom:
                        titleY = hasImage ? CGRectGetMaxY(imageFrame) + _textPadding : _edge.top;
                        break;
                        
                    case ButtonTitleAlimentLeft:
                    case ButtonTitleAlimentTop:
                    case ButtonTitleAlimentRight:
                    default:
                        titleY = _edge.top;
                        break;
                }
                break;
            case UIControlContentVerticalAlignmentBottom:
                switch (self.titleAliment) {
                    case ButtonTitleAlimentTop:
                        titleY = hasImage? contentRect.size.height - CGRectGetMinY(imageFrame)- _textPadding - titleH : contentRect.size.height  - titleH - _edge.bottom;
                        break;
                        
                    case ButtonTitleAlimentBottom:
                    case ButtonTitleAlimentLeft:
                    case ButtonTitleAlimentRight:
                    default:
                        titleY = CGRectGetMaxY(contentRect) - _edge.bottom - titleH;
                        break;
                }
                break;
            case UIControlContentVerticalAlignmentFill:
                switch (self.titleAliment) {
                    case ButtonTitleAlimentTop:
                        titleY = hasImage? (contentRect.size.height - CGRectGetMinY(imageFrame) - titleH)*0.5 :titleCenterY ;
                        break;
                        
                    case ButtonTitleAlimentBottom:
                        titleY = hasImage?(contentRect.size.height - CGRectGetMaxY(imageFrame) - titleH)*0.5 + CGRectGetMaxY(imageFrame):titleCenterY;
                        break;
                    case ButtonTitleAlimentLeft:
                    case ButtonTitleAlimentRight:
                    default:
                        titleY = titleCenterY;
                        break;
                }
                break;
            case UIControlContentVerticalAlignmentCenter:
            default:
                switch (self.titleAliment) {
                    case ButtonTitleAlimentTop:
                        titleY = hasImage ? CGRectGetMinY(imageFrame)-_textPadding - titleH : titleCenterY;
                        break;
                        
                    case ButtonTitleAlimentBottom:
                        titleY = hasImage ?CGRectGetMaxY(imageFrame) + _textPadding : titleCenterY;
                        break;
                    case ButtonTitleAlimentLeft:
                    case ButtonTitleAlimentRight:
                    default:
                        titleY = titleCenterY ;
                        break;
                }
                break;
        }
    CGFloat titleCenterX = (contentRect.size.width - titleW)*0.5;
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentLeft:
            switch (self.titleAliment) {
                case ButtonTitleAlimentRight:
                    titleX = hasImage?CGRectGetMaxX(imageFrame)+_textPadding:_edge.left;
                    break;
                case ButtonTitleAlimentBottom:
                case ButtonTitleAlimentLeft:
                case ButtonTitleAlimentTop:
                default:
                titleX = _edge.left;
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentRight:
            switch (self.titleAliment) {
                case ButtonTitleAlimentLeft:
                    titleX = hasImage?CGRectGetMinX(imageFrame)-_textPadding - titleW :contentRect.size.width - _edge.right - titleW;
                    break;
                case ButtonTitleAlimentBottom:
                case ButtonTitleAlimentRight:
                case ButtonTitleAlimentTop:
                default:
                    titleX = contentRect.size.width - _edge.right - titleW;
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentFill:
            switch (self.titleAliment) {
                case ButtonTitleAlimentLeft:
                    titleX = hasImage?(contentRect.size.width - CGRectGetMinX(imageFrame)-titleW-_textPadding) *0.5:titleCenterX;
                    break;
                case ButtonTitleAlimentRight:
                    titleX = hasImage? contentRect.size.width - (contentRect.size.width - (imageFrame.size.width+titleW+_textPadding)) *0.5 - titleW:titleCenterX;
                    break;
                case ButtonTitleAlimentBottom:
                case ButtonTitleAlimentTop:
                default:
                    titleX = titleCenterX;
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentCenter:
        default:
            switch (self.titleAliment) {
                case ButtonTitleAlimentLeft:
                    titleX = hasImage?CGRectGetMinX(imageFrame)-_textPadding - titleW :titleCenterX;
                    break;
                case ButtonTitleAlimentRight:
                    titleX = hasImage ? CGRectGetMaxX(imageFrame)+_textPadding:titleCenterX;
                    break;
                case ButtonTitleAlimentBottom:
                case ButtonTitleAlimentTop:
                default:
                    titleX = titleCenterX;
                    break;
            }
            break;
    }

    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 1.计算文字的尺寸
    self.titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    //没有主观限制图片的尺寸的时候 默认按照图片的实际尺寸
    if(CGSizeEqualToSize(self.imageSize, CGSizeZero))
    self.imageSize = image.size;
}

@end
