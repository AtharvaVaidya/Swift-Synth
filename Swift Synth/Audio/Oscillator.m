//
//  Oscillator.m
//  Swift Synth
//
//  Created by Atharva Vaidya on 1/7/20.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import "Oscillator.h"

static float _amplitude = 1.0f;
static float _frequency = 440.0f;

@implementation Oscillator

+ (float)amplitude {
    return _amplitude;
}

+ (float)frequency {
    return _frequency;
}

+ (void)setAmplitude:(float)amplitude {
    _amplitude = amplitude;
}

+ (void)setFrequency:(float)frequency {
    _frequency = frequency;
}

+ (Signal)sine {
    return ^float(float time) {
        return _amplitude * sinf(2.0 * M_PI * _frequency * time);
    };
}

+ (Signal)triangle {
    Signal signal = ^float(float time) {
        double period = 1.0 / (double)_frequency;
        double currentTime = fmod((double)time, period);
        
        double value = currentTime / period;
        
        double result = 0.0;
        
        if (value < 0.25) {
            result = value * 4;
        } else if (value < 0.75) {
            result = 2.0 - (value * 4.0);
        } else {
            result = value * 4 - 4.0;
        }
        
        return _amplitude * (float)result;
    };
    
    return signal;
}

@end
