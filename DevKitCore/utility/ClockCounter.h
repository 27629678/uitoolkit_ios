//
//  ClockCounter.h
//  mail
//
//  Created by Yuheng on 14-10-15.
//  Copyright (c) 2014年 sddz_yuxiaohua (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClockCounter : NSObject

- (void)start;

- (void)stop;

- (NSUInteger)interval;

@end
