//
//  NSData+AES.h
//  mail
//
//  Created by Yuheng on 14-8-29.
//  Copyright (c) 2014年 sddz_yuxiaohua (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)

- (NSData *)AES128EncryptWithKey:(NSString *)key;

- (NSData *)AES128DecryptWithKey:(NSString *)key;

- (NSData *)AES256EncryptWithKey:(NSString *)key;

- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
