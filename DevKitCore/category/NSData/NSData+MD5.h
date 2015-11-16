//
//  NSData+MD5.h
//  Demo
//
//  Created by sddz_yuxiaohua on 15/10/10.
//  Copyright © 2015年 sddz_yuxiaohua (hangzhou) Network Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MD5)

- (NSData*)md5Data;

- (NSString*)hexLowerString;

- (NSString*)hexUpperString;

@end
