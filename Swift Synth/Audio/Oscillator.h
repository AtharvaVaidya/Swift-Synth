//
//  Oscillator.h
//  Swift Synth
//
//  Created by Atharva Vaidya on 1/7/20.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Signal.h"

@interface Oscillator : NSObject

+ (float)amplitude;
+ (float)frequency;

+ (void)setAmplitude:(float)amplitude;
+ (void)setFrequency:(float)frequency;

+ (Signal __nonnull)sine;
+ (Signal __nonnull)triangle;
+ (Signal __nonnull)sawtooth;
+ (Signal __nonnull)square;
+ (Signal __nonnull)whiteNoise;

@end
