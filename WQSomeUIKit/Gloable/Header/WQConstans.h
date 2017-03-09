//
//  Constans.h
//  SomeUIKit
//
//  Created by WangQiang on 2016/10/20.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#ifndef Constans_h
#define Constans_h

#define UIColorMake(R,G,B) ([UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1.0])
#define UIColorMakeA(r, g, b, a) [UIColor colorWithRed:r / 255. green:g / 255. blue:b / 255. alpha:a]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f]
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:alphaValue]

#define TopHeight 64.0
#define BottomHeight 49.0

#define TITLE1  UIColorMakeA(12,12,13,1)
#define TITLE2  UIColorMakeA(85,86,89,1)
#define TITLE3  UIColorMakeA(157,160,166,1)
#define TITLE4  UIColorMakeA(195,197,204,1)

#define APP_WIGHT [[UIScreen mainScreen] bounds].size.width
#define APP_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define MYFont(a) [UIFont systemFontOfSize:(a)]
#define MYFontM(a)   [UIFont boldSystemFontOfSize:(a)]

#define LightGreen UIColorMake(134, 185, 59)

#endif /* Constans_h */
