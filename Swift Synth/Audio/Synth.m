//
//  Synth.m
//  Swift Synth
//
//  Created by Atharva Vaidya on 1/7/20.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import "Synth.h"
#import <AVFoundation/AVFoundation.h>

@implementation Synth
{
    AVAudioEngine *audioEngine;
    float time;
    double sampleRate;
    float deltaTime;
    
    AVAudioSourceNode *_sourceNode;
    Signal _signal;
}

+ (Synth *)sharedInstance {
    static Synth *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[Synth alloc] init];
    });
    
    return shared;
}

- (instancetype)initWithSignal:(Signal)signal {
    self = [super init];
    
    if (self) {
        audioEngine = [[AVAudioEngine alloc] init];
        
        AVAudioMixerNode *mainMixer = audioEngine.mainMixerNode;
        AVAudioOutputNode *outputNode = audioEngine.outputNode;
        AVAudioFormat *format = [audioEngine.outputNode inputFormatForBus:0];
        
        sampleRate = format.sampleRate;
        deltaTime = 1 / sampleRate;
        
        _signal = signal;
        
        AVAudioFormat *inputFormat = [[AVAudioFormat alloc] initWithCommonFormat:format.commonFormat
                                                                      sampleRate:sampleRate
                                                                        channels:1
                                                                     interleaved:format.isInterleaved];
        //This initializes the source node.
        AVAudioSourceNode *sourceNode = [self sourceNode];
        
        [audioEngine attachNode:sourceNode];
        [audioEngine connect:sourceNode to:mainMixer format:inputFormat];
        [audioEngine connect:mainMixer to:outputNode format:nil];
        
        [mainMixer setOutputVolume:0];
        
        NSError *audioEngineStartError;
        BOOL couldStartEngine = [audioEngine startAndReturnError:&audioEngineStartError];
        
        if (!couldStartEngine) {
            return nil;
        }
    }
    
    return self;
}

//MARK:- Volume Functions
- (void)setVolume:(float)volume {
    [audioEngine.mainMixerNode setOutputVolume:volume];
}

- (float)volume {
    return audioEngine.mainMixerNode.outputVolume;
}

//MARK:- Waveform Functions
- (void)setWaveformToSignal:(Signal)signal {
    _signal = signal;
}

//MARK:- Source Node Creation Function
- (AVAudioSourceNode *)sourceNode {
    if (!_sourceNode) {
        AVAudioSourceNode *node = [[AVAudioSourceNode alloc] initWithRenderBlock:^OSStatus(BOOL * _Nonnull isSilence, const AudioTimeStamp * _Nonnull timestamp, AVAudioFrameCount frameCount, AudioBufferList * _Nonnull outputData) {
            
            Float32 *outputBuffer = (Float32 *)outputData->mBuffers[0].mData;

            for (int frame = 0; frame < frameCount; frame++) {
                float sampleVal = self->_signal(self->time);
                self->time += self->deltaTime;
                
                outputBuffer[frame] = sampleVal;
            }
            
            return noErr;
        }];
        
        _sourceNode = node;
    }
    
    return _sourceNode;
}

@end
