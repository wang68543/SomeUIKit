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
 音频格式转换(可能下载的格式iOS无法播放所以需要转换)
 
 @param originalData 下载下来的原始数据
 @return 转换后的数据
 */
typedef NSData * (^ConvertDownloadVoiceBlock)(NSData *originalData);

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
-(void)playWithPath:(NSString *)path
        downFinshed:(DowonFinshBlock)downFinsh
        compeletion:(PlayFinshBlock)compeleletion;
-(void)playWithPath:(NSString *)path
       convertVoice:(ConvertDownloadVoiceBlock)convertBlock
        downFinshed:(DowonFinshBlock)downFinsh
        compeletion:(PlayFinshBlock)compeleletion;
/**
 音频播放

 @param path 音频路径
 @param cachePath 音频缓存路径
 @param convertBlock 下载的音频转换后播放 //FIXME: 这里默认没有转换 (转换需添加框架框架比较大)
 @param downFinsh 音频下载完成
 @param compeleletion 音频播放完成
 */
-(void)playWithPath:(NSString *)path
         cachePath:(NSString *)cachePath
       convertVoice:(ConvertDownloadVoiceBlock)convertBlock
        downFinshed:(DowonFinshBlock)downFinsh
        compeletion:(PlayFinshBlock)compeleletion;
/**外部停止播放(会回调block)*/
-(void)stopCurrentPlayer;
/**采用默认的录音名字(由当前设备的唯一标识与当前时间组成的格式wav)*/
-(NSError *)record;
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
//FIXME:这里需要导入一个第三方的库文件才能调用
//-(void)wavData:(NSData *)data toAmr:(void (^)(NSData *))compeletion;

/**拷贝文件*/
+(void)copyFile:(NSString *)filePath targetPath:(NSString *)targetPath;

@end
