//
//  WQVoiceTool.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/12/30.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "WQVoiceTool.h"
#import <AVFoundation/AVFoundation.h>
#import "WQCache.h"
//#import "amrFileCodec.h"


@interface WQVoiceTool()<AVAudioPlayerDelegate>
@property (strong ,nonatomic) NSOperationQueue *operationQueue;

@property (strong ,nonatomic) AVAudioPlayer *player;
@property (nonatomic, strong) AVAudioRecorder *recorder;

@property (copy ,nonatomic) PlayFinshBlock playfinsh;
@end
@implementation WQVoiceTool

-(NSOperationQueue *)operationQueue{
    if(!_operationQueue){
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 5;
    }
    return _operationQueue;
}
-(void)addJobToQueue:(void (^)(void))block{
    [self.operationQueue addOperationWithBlock:block];
}

static id _instace;
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}
- (instancetype)copyWithZone:(NSZone *)zone{
    return _instace;
}

@synthesize recording = _recording;
-(BOOL)isRecording{
    _recording =  self.recorder && self.recorder.isRecording;
    return _recording;
}
@synthesize playing = _playing;
-(BOOL)isPlaying{
    _playing = self.player && self.player.isPlaying;
    return _playing;
}

#pragma mark -- 语音播放

-(void)playWithPath:(NSString *)path downFinshed:(DowonFinshBlock)downFinsh compeletion:(PlayFinshBlock)compeleletion{
    [self stopCurrentPlayer];
    __weak typeof(self) weakSelf = self;
    [self downloadVoice:path compeletion:^(NSError *error, NSData *voiceData, VoiceCacheType cacheType) {
        !downFinsh?:downFinsh(error,voiceData,cacheType);
        if(error){
            !compeleletion?:compeleletion(error,YES);
        }else{
           weakSelf.player = [[AVAudioPlayer alloc] initWithData:voiceData error:&error];
            if(error){
                !compeleletion?:compeleletion(error,YES);
            }else{
                AVAudioSession *audioSession = [AVAudioSession sharedInstance];
                NSError *err = nil;
                [audioSession setCategory :AVAudioSessionCategoryPlayback error:&err];
                if([weakSelf.player prepareToPlay] && [weakSelf.player play]){
                    weakSelf.playfinsh = [compeleletion copy];
                    weakSelf.player.delegate = weakSelf;
                }else{
                    !compeleletion?:compeleletion([self errorWithMsg:@"播放失败"],YES);
                }
            }
        }
    }];
}

#pragma mark -- 下载语音
-(void)downloadVoice:(NSString *)path compeletion:(DowonFinshBlock)downFinshed{
     NSURL *url = [NSURL URLWithString:path];
    if(!url){
        !downFinshed?:downFinshed([self errorWithMsg:@"音频文件路径不存在"],nil,VoiceCacheTypeNone);
        return;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_block_t block = ^(){
        NSString *lastPath = url.lastPathComponent;
        NSString *path = [[NSFileManager pathForVoiceDirectory] stringByAppendingPathComponent:lastPath];
        //先从缓存中取
        NSData *data = [self voiceDataWithPath:path];
        VoiceCacheType cacheType;
        if(data){
            cacheType = VoiceCacheTypeDisk;
        }else{
            cacheType = VoiceCacheTypeNone;
            data = [NSData dataWithContentsOfURL:url];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error;
            if(!data){
                error = [weakSelf errorWithMsg:@"音频文件下载失败"];
            }else{
                if(data)[data writeToFile:path atomically:YES];
            }
            !downFinshed?:downFinshed(error,data,cacheType);
        });
    };
    [self addJobToQueue:block];
}

/**从缓存中获取语音*/
-(NSData *)voiceDataWithPath:(NSString *)path{
    if(!path){
        return nil;
    }else{
        NSData *data = [NSData dataWithContentsOfFile:path];
        return data;
    }
}

#pragma mark -- 停止语音播放
//-(void)stopPlay{
//    [self stopCurrentPlayer];//
//    //暂时不确定代理是否会响应
//     !self.playfinsh?:self.playfinsh(nil,NO);
//}
#pragma mark -- 内部终止当前的语音播放
-(void)stopCurrentPlayer{
    if(self.isPlaying){
        [self.player stop];//主动停止 不会调代理方法
        !self.playfinsh?:self.playfinsh(nil,NO);
    }
}
#pragma mark -- AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    !self.playfinsh?:self.playfinsh(nil,flag);
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error{
    !self.playfinsh?:self.playfinsh(error,YES);
}


#pragma mark -- 
//获取录音设置
- (NSDictionary*)GetAudioRecorderSettingDict{
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey, //采样率
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,//通道的数目
                                   //                                   [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,//大端还是小端 是内存的组织方式
                                   //                                   [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,//采样信号是整数还是浮点数
                                   //                                   [NSNumber numberWithInt: AVAudioQualityMedium],AVEncoderAudioQualityKey,//音频编码质量
                                   nil];
    return recordSetting;
}
#pragma mark -- 内部终止当前的录音
-(void)stopCurrentRecorder{
    if(self.isRecording ){
        [self.recorder stop];
        [self.recorder deleteRecording];
    }
}

-(NSError *)recordWithName:(NSString *)name{
    return [self recordWithPath:[[NSFileManager pathForVoiceDirectory] stringByAppendingPathComponent:name]];
}
/**直接将录音文件存放到指定的路径下*/
-(NSError *)recordWithPath:(NSString *)path{
    [self stopCurrentRecorder];
    NSError *error;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *setCategoryError = nil;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&setCategoryError];
    
    if(setCategoryError){
        NSLog(@"%@", [setCategoryError description]);
    }
    
    self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:path] settings:[self GetAudioRecorderSettingDict] error:&error];
    if(![self.recorder prepareToRecord] && error){
        error = [self errorWithMsg:@"开启录音失败"];
    }else{
            [self.recorder record];
        }
    
    return error;
}

-(void)stopRecordCompeletion:(RecordFinshBlock)recordFinsh{
    if(self.isRecording){
        CGFloat recordLength = self.recorder.currentTime ;
        [self.recorder stop];
        if(recordFinsh){
            BOOL saveRecordFile =  recordFinsh(nil,self.recorder.url.absoluteString,recordLength);
            if(!saveRecordFile){
                [self.recorder deleteRecording];
            }
        }
    }else{
        if(recordFinsh){
           recordFinsh([self errorWithMsg:@"未开启录音"],nil,0.0);
        }
      
    }
}
#pragma mark -- /**录音格式转换*/
-(void)wavData:(NSData *)data toAmr:(void (^)(NSData *))compeletion{
//    __weak typeof(self) weakSelf = self;
//    dispatch_block_t block = ^(){
//         NSData *amrData = [weakSelf wavToAmr:data];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            !compeletion?:compeletion(amrData);
//        });
//    };
//    [self addJobToQueue:block];
}
#pragma mark -- wav与amr相互转换
//-(NSData *)decodeAmr:(NSData *)data{
//    if (!data) {
//        return data;
//    }
//    return DecodeAMRToWAVE(data);
//}
//-(NSData *)wavToAmr:(NSData *)data{
//    if(!data) return data;
//    return  EncodeWAVEToAMR(data,1,16);
//}

-(NSError *)errorWithMsg:(NSString *)msg{
   return  [NSError errorWithDomain:NSStringFromClass([self class]) code:-3000 userInfo:@{NSLocalizedDescriptionKey:msg}];
}
@end
