//
//  UIImageView+Animation.h
//  NEDevKit
//
//  Created by sddz_yuxiaohua on 15/10/15.
//
//

#import <UIKit/UIKit.h>

@interface UIImageView (Animation)

- (void)animateWithPattern:(NSString *)pattern frames:(NSInteger)frames;

- (void)animateWithPattern:(NSString *)pattern frames:(NSInteger)frames reverse:(BOOL)isReverse;

- (void)animateWithPattern:(NSString *)pattern frames:(NSInteger)frames repeatCount:(NSInteger)repeatCount reverse:(BOOL)isReverse finish:(void(^)())finish;

@end
