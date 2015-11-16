//
//  ClockCounter.m
//  mail
//
//  Created by Yuheng on 14-10-15.
//  Copyright (c) 2014年 sddz_yuxiaohua (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "ClockCounter.h"
#include <mach/mach.h>
#include <mach/mach_time.h>

@interface ClockCounter () {
    uint64_t    _start;
    uint64_t    _end;
    uint64_t    _elapsed;
    uint64_t    _elapsedNano;
}
@end

@implementation ClockCounter

- (void)start
{
    _end = 0;
    _elapsed = 0;
    _elapsedNano = 0;
    _start = mach_absolute_time();
}

- (void)stop
{
    static mach_timebase_info_data_t sTimebaseInfo;
    _end = mach_absolute_time();
    _elapsed = _end - _start;
    if (sTimebaseInfo.denom == 0) {
        (void) mach_timebase_info(&sTimebaseInfo);
    }
    _elapsedNano = _elapsed * sTimebaseInfo.numer / sTimebaseInfo.denom;
}

- (NSUInteger)interval
{
    return (NSUInteger)(_elapsedNano * 1000ull / NSEC_PER_SEC);
}

@end
