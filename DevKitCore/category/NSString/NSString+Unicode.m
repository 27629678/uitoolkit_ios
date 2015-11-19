//
//  NSString+Unicode.m
//  Demo
//
//  Created by sddz_yuxiaohua on 15/10/10.
//  Copyright © 2015年 X Co., Ltd. All rights reserved.
//

#import "NSString+Unicode.h"

@implementation NSString (Unicode)

- (NSString *)unicodeString
{
    NSData* data = [self dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
