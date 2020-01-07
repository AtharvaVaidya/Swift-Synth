//
//  Synth.h
//  Swift Synth
//
//  Created by Atharva Vaidya on 1/7/20.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Signal.h"

@interface Synth : NSObject

@property (nonatomic, assign) float volume;

- (instancetype _Nullable )initWithSignal:(Signal _Nonnull )signal;

+ (Synth * _Nonnull )sharedInstance;

- (void)setWaveformToSignal:(Signal _Nonnull )signal;
- (BOOL)isPlaying;

@end
