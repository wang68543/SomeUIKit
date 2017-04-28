//
//  WQPayTool.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/4/25.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQPayTool.h"
@interface WQPayTool()
@property (strong ,nonatomic) WQPayItem *payItem;
@property (copy ,nonatomic) WQPayCompeletion payComepletion;
@end
@implementation WQPayTool
+(instancetype)payManager{
    static WQPayTool *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(void)sendPay:(WQPayItem *)payItem compeletion:(WQPayCompeletion)payComepeltion{
    _payItem = payItem;
    _payComepletion = [payComepeltion copy];
    
    if(payItem.payType == kPayZhiFuBao){
        [self payWithZhiFuBao];
    }else{
        [self payWithWeiXin];
    }
}

- (void)payWithZhiFuBao{
    
}

-(void)payWithWeiXin{
    
}

-(BOOL)handleOpenURL:(NSURL *)url{
    //这里处理支付宝跟微信回调
    //微信支付取消url: wx49bbbadfb77cbbbd://pay/?returnKey=(null)&ret=-2
    //微信支付成功url: wx49bbbadfb77cbbbd://pay/?returnKey=&ret=0
    /**
     * url.scheme wx49bbbadfb77cbbbd
     * url.query returnKey=&ret=0
     * url.host pay
     */
    
    /**
     ** [url.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] url需要解码*
     *支付宝支付取消: zfb2016072701674288://safepay/?{"memo":{"result":"","memo":"用户中途取消","ResultStatus":"6001"},"requestType":"safepay"}
     
     *  url.host safepay
     */
    
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSString *message = @"";
//            PayResultState state =kPayDefault;
//            switch ([[resultDic objectForKey:@"resultStatus"] intValue]) {
//                case 9000:
//                    
//                    message = @"支付成功";
//                    state = kPaySuccess;
//                    break;
//                case 6001:
//                    //用户中途取消
//                    message = @"支付取消";
//                    state = kPayCanceled;
//                    break;
//                case 8000://正在处理中
//                case 4000://订单支付失败
//                case 6002://网络连接出错
//                    message = @"支付失败";
//                    state = kPayFailed;
//                    break;
//                default:
//                    message = @"支付失败";
//                    state = kPayFailed;
//                    break;
//            }
//            if ([self.delegate respondsToSelector:@selector(payToolPayState:message:type:)]) {
//                [self.delegate payToolPayState:state message:message type:kPayZhiFuBao];
//            }
//        }];
        return YES;
    }else if([url.host isEqualToString:@"pay"] && [url.scheme isEqualToString:@"wx49bbbadfb77cbbbd"]){
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:[url.query dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSString *message = @"";
        PayResultState state =kPayDefault;
        if(results){
            NSInteger code = [[results objectForKey:@"ret"] integerValue];
            if(code == 0){
                state = kPaySuccess;
                message = @"微信支付成功";
            }else if(code == -2){
                state = kPayFailed;
                message = @"用户取消支付";
            }else{
                state = kPayFailed;
                message = @"微信支付失败";
            }
        }else{
            state = kPayFailed;
            message = @"微信支付失败";
        }
        return YES;
    }
    
    
    return NO;
}
@end
