//
//  WQVoiceTool.h
//  SomeUIKit
//
//  Created by WangQiang on 2016/12/30.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,VoiceCacheType) {
    VoiceCacheTypeNone,
    VoiceCacheTypeDisk,
};

/**
 播放结果回调

 @param error 播放错误信息
 @param finshed 只有外部终止了才传NO
 */
typedef void(^PlayFinshBlock)(NSError *error , BOOL finshed);
typedef void (^DowonFinshBlock)(NSError *error ,NSData *voiceData,VoiceCacheType cacheType);

/**
 录音完成回调

 @param error 录音停止出错
 @param recordPath 录音文件保存的路径
 @param duration 录音时长
 @return 是否保留录音文件
 */
typedef BOOL (^RecordFinshBlock)(NSError *error,NSString *recordPath,CGFloat duration);
@interface WQVoiceTool : NSObject
+(instancetype)sharedInstance;


@property (assign ,nonatomic,readonly,getter=isRecording) BOOL recording;

@property (assign ,nonatomic,readonly,getter=isPlaying) BOOL playing;

/**根据语音的url下载并播放并缓存到固定的路径*/
-(void)playWithPath:(NSString *)path downFinshed:(DowonFinshBlock)downFinsh compeletion:(PlayFinshBlock)compeleletion;
/**外部停止播放(会回调block)*/
-(void)stopCurrentPlayer;
/**
 直接将录音文件存放到指定的目录下

 @param name 文件名
 @return 开启录音出错信息
 */
-(NSError *)recordWithName:(NSString *)name;
/**直接将录音文件存放到指定的路径下(有时候路径存在但就是无法存储 尝试下重启)*/
-(NSError *)recordWithPath:(NSString *)path;

/**停止录音*/
-(void)stopRecordCompeletion:(RecordFinshBlock)recordFinsh;

/**录音格式转换*/
-(void)wavData:(NSData *)data toAmr:(void (^)(NSData *))compeletion;
@end
