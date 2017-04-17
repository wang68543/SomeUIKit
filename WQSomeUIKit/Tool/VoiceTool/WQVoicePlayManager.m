//
//  WQVoiceManager.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/4/14.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQVoicePlayManager.h"
#import <AVFoundation/AVFoundation.h>
#import "WQVoiceCache.h"

@interface WQVoicePlayManager()<AVAudioPlayerDelegate>
@property (strong ,nonatomic) AVAudioPlayer *player;

@property (copy ,nonatomic) WQVoicePlayFinshBlock playFinshed;
@property (copy ,nonatomic) NSString *currentURL;
@end
@implementation WQVoicePlayManager
static WQVoicePlayManager *_instance;
+(instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] initWithCache:[WQVoiceCache sharedCache] downloader:[WQVoiceDownloader sharedVoiceDownloader]];
    });
    return _instance;
}
-(instancetype)initWithCache:(WQVoiceCache *)cache downloader:(WQVoiceDownloader *)downloader{
    if(self = [super init]){
        _voiceCache = cache;
        _downloader = downloader;
        _cachePocilty = WQVoiceCacheTypeDisk;
    }
    return self;
}
-(BOOL)isPlaying{
    return self.player && self.player.isPlaying;
}

-(void)stopCurrentPlay{
    if(self.isPlaying){
        [self.player stop];
        //中途被打断
        _playFinshed ? _playFinshed(nil,_currentURL,NO):nil;
        _playFinshed = nil;
        self.player = nil;
        _currentURL = nil;
    }
}
-(void)playWithData:(NSData *)data{
     NSError *error;
    do {
        self.player = [[AVAudioPlayer alloc] initWithData:data error:&error];
        if(error) break;
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:&error];
        if(error) break;
        if(![self.player prepareToPlay] || ![self.player play]){
            error = [NSError errorWithDomain:WQVoiceErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey : @"播放失败"}];
        }
    } while (NO);
    if(error){
        _playFinshed ? _playFinshed(error,_currentURL,YES):nil;
        _currentURL = nil;
        _player = nil;
        _playFinshed = nil;
    }else{
       self.player.delegate = self;
    }
}
- (void)play:(NSString *)voicePath
   playFinsh:(WQVoicePlayFinshBlock)playFinshedBlock{
    [self play:voicePath downFinsh:nil playFinsh:playFinshedBlock];
}
-(void)play:(NSString *)voicePath downFinsh:(WQVoiceDowonFinshBlock)downFinshedBlock playFinsh:(WQVoicePlayFinshBlock)playFinshedBlock{
    NSString *key = [_voiceCache cacheKeyForURL:voicePath];
    __weak typeof(self) weakSelf = self;
    [_voiceCache queryVoiceCacheForKey:key done:^(NSData *voiceData, WQVoiceCacheType cacheType) {
        if(voiceData){
            downFinshedBlock?downFinshedBlock(voiceData,cacheType,voicePath,nil):nil;
             [weakSelf stopCurrentPlay];
            _currentURL = voicePath;
            _playFinshed = [playFinshedBlock copy];
            [weakSelf playWithData:voiceData];
        }else{
            [_downloader downloadVoiceWithURL:[NSURL URLWithString:voicePath] completed:^(NSData *voiceData, WQVoiceCacheType cacheType, NSString *urlStr, NSError *error) {
                if(voiceData){
                  downFinshedBlock?downFinshedBlock(voiceData,cacheType,urlStr,nil):nil;
                    [weakSelf stopCurrentPlay];
                    _currentURL = urlStr;
                    _playFinshed = [playFinshedBlock copy];
                    [weakSelf playWithData:voiceData];
                    [weakSelf.voiceCache storeVoice:voiceData forKey:key];
                }else{
                    
                   downFinshedBlock?downFinshedBlock(voiceData,cacheType,urlStr,error):nil;
                    [weakSelf stopCurrentPlay];
                    _playFinshed = nil;
                    playFinshedBlock?playFinshedBlock(error,urlStr,YES):nil;
                }
            }];
        }
    }];
}

#pragma mark -- AVAudioPlayerDelegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    _playFinshed ? _playFinshed(nil,_currentURL,flag):nil;
    _player = nil;
}
-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    _playFinshed ? _playFinshed(error,_currentURL,YES):nil;
    _player = nil;
}
- (void)dealloc{
    if(self.isPlaying){
        [self.player stop];
    }
    NSLog(@"===播放工具销毁了");
}
@end
