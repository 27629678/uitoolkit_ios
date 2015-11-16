//
//  NSObject+NELog.h
//  mailtool
//
//  Created by sddz_yuxiaohua on 15/9/25.
//  Copyright © 2015年 h-yxh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NELogLevel) {
    kNELogLevelMute         = 0,    // no log write to console
    kNELogLevelError        = 1,
    kNELogLevelWarn         = 2,
    kNELogLevelInfo         = 3,
    kNELogLevelDebug        = 4,
    kNELogLevelVerbose      = 5,
};

#define NEErrorLog(format, ...) do { if ([self logLevelForNELog] > kNELogLevelMute) { NSLog((format), ##__VA_ARGS__); }} while(0)
#define NEWarnLog(format, ...) do { if ([self logLevelForNELog] > kNELogLevelError) { NSLog((format), ##__VA_ARGS__); }} while(0)
#define NEInfoLog(format, ...) do { if ([self logLevelForNELog] > kNELogLevelWarn) { NSLog((format), ##__VA_ARGS__); }} while(0)
#define NEDebugLog(format, ...) do { if ([self logLevelForNELog] > kNELogLevelInfo) { NSLog((format), ##__VA_ARGS__); }} while(0)
#define NEVerboseLog(format, ...) do { if ([self logLevelForNELog] > kNELogLevelDebug) { NSLog((format), ##__VA_ARGS__); }} while(0)

@interface NSObject (NELog)

- (NELogLevel)logLevelForNELog;

@end
