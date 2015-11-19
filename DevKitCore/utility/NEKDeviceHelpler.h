//
//  NEKDeviceHelpler.h
//  Demo
//
//  Created by sddz_yuxiaohua on 15/10/10.
//  Copyright © 2015年 X Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEKDeviceHelpler : NSObject

+ (NSString *)deviceName;

+ (NSString *)systemVersion;

+ (NSString *)systemBuildVersion;

+ (NSString *)deviceDescription;

+ (BOOL)isSupportTouchID;

+ (BOOL)isTouchIDEnabled;

+ (BOOL)isNotificationEnabled;

+ (BOOL)isSupportSpotlightSearch;

@end
