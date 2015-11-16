//
//  NEKDeviceHelpler.m
//  Demo
//
//  Created by sddz_yuxiaohua on 15/10/10.
//  Copyright © 2015年 sddz_yuxiaohua (hangzhou) Network Co.,Ltd. All rights reserved.
//

#import "NEKDeviceHelpler.h"

#import <sys/sysctl.h>
#import <UIKit/UIKit.h>

static NSString* _retrieve_system_build_version()
{
    int mib[2] = {CTL_KERN, KERN_OSVERSION};
    u_int namelen = sizeof(mib) / sizeof(mib[0]);
    size_t bufferSize = 0;
    
    NSString *osBuildVersion = nil;
    
    // Get the size for the buffer
    sysctl(mib, namelen, NULL, &bufferSize, NULL, 0);
    
    u_char buildBuffer[bufferSize];
    int result = sysctl(mib, namelen, buildBuffer, &bufferSize, NULL, 0);
    
    if (result >= 0) {
        // Terminated by '\0'
        if (bufferSize > 0 && buildBuffer[bufferSize-1] == 0) {
            bufferSize--;
        }
        osBuildVersion = [[NSString alloc] initWithBytes:buildBuffer length:bufferSize encoding:NSUTF8StringEncoding];
    }
    
    return osBuildVersion;
}

@interface NEKDeviceInfo : NSObject

@property (nonatomic) NSString* name;
@property (nonatomic) NSString* model;
@property (nonatomic) NSString* version;
@property (nonatomic) NSString* buildVersion;
@property (nonatomic) NSString* vendorID;

+ (instancetype)sharedInstance;

@end

@implementation NEKDeviceInfo

+ (instancetype)sharedInstance
{
    static NEKDeviceInfo* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [instance setName:[[UIDevice currentDevice] name]];
        [instance setModel:[[UIDevice currentDevice] model]];
        [instance setVersion:[[UIDevice currentDevice] systemVersion]];
        [instance setBuildVersion:_retrieve_system_build_version()];
        [instance setVendorID:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
    });
    
    return instance;
}

@end

@implementation NEKDeviceHelpler

+ (NSString *)deviceName
{
    return [[NEKDeviceInfo sharedInstance] name];
}

+ (NSString *)systemVersion
{
    return [[NEKDeviceInfo sharedInstance] version];
}

+ (NSString *)systemBuildVersion
{
    return [[NEKDeviceInfo sharedInstance] buildVersion];
}

+ (NSString *)deviceDescription
{
    return nil;
}

+ (BOOL)isSupportTouchID
{
    
    return NO;
}

+ (BOOL)isTouchIDEnabled
{
    return NO;
}

+ (BOOL)isNotificationEnabled
{
    return NO;
}

+ (BOOL)isSupportSpotlightSearch
{
    return NO;
}

@end
