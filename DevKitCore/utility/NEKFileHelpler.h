//
//  NEKFileHelpler.h
//  Demo
//
//  Created by sddz_yuxiaohua on 15/10/10.
//  Copyright © 2015年 sddz_yuxiaohua (hangzhou) Network Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEKFileHelpler : NSObject

+ (instancetype)fileWithPath:(NSString *)path;

- (BOOL)isFileExist;

- (BOOL)isDirectoryExist;

- (NSUInteger)fileSize;

- (NSDictionary *)fileAttributes;

@end

@interface NEKFileHelpler (Directory)

+ (NSString *)pathForCache;

+ (NSString *)pathForLibrary;

+ (NSString *)pathForDocument;

@end

// Uniform Type Identification API
// <MobileCoreServices/UTType.h>
@interface NEKFileHelpler (Extensions)

@end
