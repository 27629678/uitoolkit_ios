//
//  NSURL+NEKEx.m
//  Demo
//
//  Created by sddz_yuxiaohua on 15/10/9.
//  Copyright © 2015年 sddz_yuxiaohua (hangzhou) Network Co.,Ltd. All rights reserved.
//

#import "NSURL+NEKEx.h"

extern NSString* decodeURLString(NSString *string)
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef)string, CFSTR("")));
}

@implementation NSURL (NEKEx)

+ (instancetype)urlWithAppStoreID:(NSString *)appId
{
    NSString* url = [@"https://itunes.apple.com/cn/app/id" stringByAppendingString:appId];
    
    return [NSURL URLWithString:url];
}

- (NSDictionary *)queryParameters
{
    if ([self.query isEqualToString:@""]) {
        return @{};
    }
    
    NSMutableDictionary* retDict = [NSMutableDictionary new];
    NSArray* queryComponents = [self.query componentsSeparatedByString:@"&"];
    for (NSString *component in queryComponents) {
        NSRange equalsLocation = [component rangeOfString:@"="];
        
        // no equals, associate the key with NSNull
        if (equalsLocation.location == NSNotFound) {
            retDict[decodeURLString(component)] = [NSNull null];
        }
        else {
            NSString *key = decodeURLString([component substringToIndex:equalsLocation.location]);
            NSString *value = decodeURLString([component substringFromIndex:equalsLocation.location + 1]);
            retDict[key] = value;
        }
    }
    
    return [retDict copy];
}

@end
