//
//  NEKEventCenter.h
//  Demo
//
//  Created by sddz_yuxiaohua on 15/10/9.
//  Copyright © 2015年 X Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEKEventCenter : NSObject

+ (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name;

+ (void)removeObserver:(id)observer name:(NSString *)name;

+ (void)postEventWithName:(NSString *)name;

+ (void)postEventWithName:(NSString *)name object:(id)object;

+ (void)postEventWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo;

@end
