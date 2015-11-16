//
//  UIView+Alert.h
//  NEDevKit
//
//  Created by sddz_yuxiaohua on 15/10/14.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Alert)

/// default is CGSizeMake(2,2)
- (void)setAlertPoint:(CGPoint)point;

/// default is black
- (void)setAlertLabelTintColor:(UIColor *)color;

/// default is red
- (void)setAlertBackgroundTintColor:(UIColor *)color;

- (void)showAlert;

- (void)showAlertWithCount:(NSInteger)count;

- (void)hideAlert;

@end
