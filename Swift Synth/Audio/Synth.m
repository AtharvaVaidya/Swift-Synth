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

@end
