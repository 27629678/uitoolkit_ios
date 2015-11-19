//
//  NSData+MD5.m
//  Demo
//
//  Created by sddz_yuxiaohua on 15/10/10.
//  Copyright © 2015年 X Co., Ltd. All rights reserved.
//

#import "NSData+MD5.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation NSData (MD5)

- (NSData*)md5Data
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([self bytes], (CC_LONG)[self length], result);
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

- (NSString*)hexLowerString
{
    return [self hexStringWithLower:YES];
}

- (NSString*)hexUpperString
{
    return [self hexStringWithLower:NO];
}

- (NSString*)hexStringWithLower:(BOOL)isLower
{
    NSString* formatString = @"%02X";
    if (isLower) {
        formatString = @"%02x";
    }
    // 这里必须是unsigned char,不能为signed char.
    // 如果data[i]是负数,则[NSString stringWithFormat:@"%02X", data[i]]结果为8个字符(注意负号的展开)
    const unsigned char* data = (const unsigned char*)[self bytes];
    NSUInteger length = [self length];
    NSMutableString* result = [NSMutableString stringWithCapacity:length*2];
    for(int i = 0; i < length; i++) {
        [result appendFormat:formatString, data[i]];
    }
    return result;
}


@end
