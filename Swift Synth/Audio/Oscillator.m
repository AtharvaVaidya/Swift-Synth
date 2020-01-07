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

@end
