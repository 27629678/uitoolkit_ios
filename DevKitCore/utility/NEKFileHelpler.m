//
//  NEKFileHelpler.m
//  Demo
//
//  Created by sddz_yuxiaohua on 15/10/10.
//  Copyright © 2015年 X Co., Ltd. All rights reserved.
//

#import "NEKFileHelpler.h"

@interface NEKFileHelpler ()

@property (nonatomic)  NSDictionary* attributes;

@end

@implementation NEKFileHelpler
{
    NSString* _path;
}

- (instancetype)init
{
    NSAssert(NO, @"Please use [NEKFileHelpler fileWithPath:] method instead.");
    return nil;
}

- (instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    if (self) {
        _path = path;
    }
    
    return self;
}

- (NSDictionary *)attributes
{
    if (!_path) {
        return @{};
    }
    
    if (!_attributes) {
        _attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:_path error:nil];
    }
    
    return _attributes;
}

#pragma mark - public methods

+ (instancetype)fileWithPath:(NSString *)path
{
    return [[self alloc] initWithPath:path];
}

- (BOOL)isFileExist
{
    if (!_path) {
        return NO;
    }
    
    return [[NSFileManager defaultManager] fileExistsAtPath:_path];
}

- (BOOL)isDirectoryExist
{
    if (!_path) {
        return NO;
    }
    
    BOOL isDrectory;
    [[NSFileManager defaultManager] fileExistsAtPath:_path isDirectory:&isDrectory];
    
    return isDrectory;
}

- (NSUInteger)fileSize
{
    if (!_path) {
        return 0;
    }
    
    return [[self.attributes objectForKey:NSFileSize] unsignedIntegerValue];
}

- (NSDictionary *)fileAttributes
{
    return self.attributes;
}

@end

@implementation NEKFileHelpler (Directory)

+ (NSString *)pathForCache
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)pathForLibrary
{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)pathForDocument
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

@end

@implementation NEKFileHelpler (Extensions)

@end
