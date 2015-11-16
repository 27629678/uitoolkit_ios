//
//  UIColor+NEKEx.m
//  NEDevKit
//
//  Created by sddz_yuxiaohua on 15/10/14.
//
//

#import "UIColor+NEKEx.h"

@implementation UIColor (NEKEx)

+ (instancetype)colorWithHexString:(NSString *)hex
{
    NSString* target = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    switch (target.length) {
        case 3:
            target = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                      [target substringWithRange:NSMakeRange(0, 1)],
                      [target substringWithRange:NSMakeRange(0, 1)],
                      [target substringWithRange:NSMakeRange(1, 1)],
                      [target substringWithRange:NSMakeRange(1, 1)],
                      [target substringWithRange:NSMakeRange(2, 1)],
                      [target substringWithRange:NSMakeRange(2, 1)]];
        case 6:
            target = [target stringByAppendingString:@"ff"];
            
        case 8: {
            unsigned int baseValue;
            BOOL success = [[NSScanner scannerWithString:target] scanHexInt:&baseValue];
            if (!success) {
                return nil;
            }
            
            float r = ((baseValue >> 24) & 0xFF)/255.0f;
            float g = ((baseValue >> 16) & 0xFF)/255.0f;
            float b = ((baseValue >> 8) & 0xFF)/255.0f;
            float a = ((baseValue >> 0) & 0xFF)/255.0f;
            
            return [UIColor colorWithRed:r green:g blue:b alpha:a];
            break;
        }
            
        default:
            NSAssert(NO, @"The Hex String's format is not EXPECTED.");
            break;
    }
    
    return nil;
}

@end
