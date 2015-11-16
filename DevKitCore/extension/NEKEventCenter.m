//
//  NEKEventCenter.m
//  Demo
//
//  Created by sddz_yuxiaohua on 15/10/9.
//  Copyright © 2015年 sddz_yuxiaohua (hangzhou) Network Co.,Ltd. All rights reserved.
//

#import "NEKEventCenter.h"

@implementation NEKEventCenter
{
    id _object;
    NSString* _name;
    NSDictionary* _userInfo;
}

#pragma mark - public methods

+ (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:observer selector:selector name:name object:nil];
}

+ (void)removeObserver:(id)observer name:(NSString *)name
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center removeObserver:observer name:name object:nil];
}

+ (void)postEventWithName:(NSString *)name
{
    [[[self alloc] initEventWithName:name object:nil userInfo:nil] postEventNotification];
}

+ (void)postEventWithName:(NSString *)name object:(id)object
{
    [[[self alloc] initEventWithName:name object:object userInfo:nil] postEventNotification];
}

+ (void)postEventWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo
{
    [[[self alloc] initEventWithName:name object:object userInfo:userInfo] postEventNotification];
}

#pragma mark - private methods

- (instancetype)init
{
    NSAssert(NO, @"please use [NEKEventCenter postEventWithName:args:] instead.");
    return nil;
}

- (instancetype)initEventWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo
{
    self = [super init];
    if (self) {
        _name = name;
        _object = object;
        _userInfo = userInfo;
    }
    
    return self;
}

- (void)postEventNotification
{
    if (_name.length == 0) {
        return;
    }
    
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:_name object:_object userInfo:_userInfo];
}

@end
