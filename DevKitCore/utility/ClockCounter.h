//
//  ClockCounter.h
//  mail
//
//  Created by Yuheng on 14-10-15.
//  Copyright © 2015年 X Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClockCounter : NSObject

- (void)start;

- (void)stop;

- (NSUInteger)interval;

@end
