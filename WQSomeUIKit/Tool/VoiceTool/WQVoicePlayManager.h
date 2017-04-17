//
//  WQVoiceManager.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/4/14.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WQVoiceCache.h"
#import "WQVoiceDownloader.h"

/**
 音频播放完成回调

 @param error 播放出错
 @param urlStr 音频路径
 @param finshed 是否中途被打断
 */
typedef void(^WQVoicePlayFinshBlock)(NSError *error ,NSString *urlStr,BOOL finshed);
@interface WQVoicePlayManager : NSObject
+ (instancetype)manager;
@property (strong ,nonatomic, readonly) WQVoiceCache *voiceCache;

@property (strong ,nonatomic, readonly) WQVoiceDownloader *downloader;


@property (assign ,nonatomic) WQVoiceCacheType cachePocilty;

@property (assign ,nonatomic,readonly,getter=isPlaying) BOOL playing;
/**可能有时候下载下来的是amr格式或者一些OC不支持的格式需要进行转换*/
- (instancetype)initWithCache:(WQVoiceCache *)cache downloader:(WQVoiceDownloader *)downloader;
- (void)play:(NSString *)voicePath
   playFinsh:(WQVoicePlayFinshBlock)playFinshedBlock;

- (void)stopCurrentPlay;
/**
 播放音频

 @param voicePath 音频路径
 @param downFinshedBlock 完成下载语音
 @param playFinshedBlock 播放完成(无论如何都会走这个)
 */
- (void)play:(NSString *)voicePath
   downFinsh:(WQVoiceDowonFinshBlock)downFinshedBlock
   playFinsh:(WQVoicePlayFinshBlock)playFinshedBlock;
@end
