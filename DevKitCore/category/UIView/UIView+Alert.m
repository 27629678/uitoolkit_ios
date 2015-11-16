//
//  UIView+Alert.m
//  NEDevKit
//
//  Created by sddz_yuxiaohua on 15/10/14.
//
//

#import "UIView+Alert.h"

#import <objc/runtime.h>

static void const *kNEK_AlertPoint_X = &kNEK_AlertPoint_X;
static void const *kNEK_AlertPoint_Y = &kNEK_AlertPoint_Y;

static void const *kNEK_Alert_LabelColor = &kNEK_Alert_LabelColor;
static void const *kNEK_Alert_BackgroundColor = &kNEK_Alert_BackgroundColor;

static void const *kNEK_AlertLabel = &kNEK_AlertLabel;
static void const *kNEK_BigCircleImageView = &kNEK_BigCircleImageView;
static void const *kNEK_LittleCircleImageView = &kNEK_LittleCircleImageView;

#define kNEK_AlertLabelFontSize 10
#define kNEK_BigCircleImageView_DefaultSize 16
#define kNEK_LittleCircleImageView_DefaultSize 6

@implementation UIView (Alert)

- (void)setAlertPoint:(CGPoint)point
{
    [self _nek_set_alert_center:point];
    
    // simple
    CGRect frame = [self _nek_simpleAlertView].frame;
    frame.origin = CGPointMake(point.x, point.y);
    [[self _nek_simpleAlertView] setFrame:frame];
    
    // detail
    frame = [self _nek_detailAlertView].frame;
    frame.origin = CGPointMake(point.x, point.y);
    [[self _nek_detailAlertView] setFrame:frame];
    
    // label
    CGSize size = frame.size;
    frame = [self _nek_alertLabel].frame;
    frame.origin = CGPointMake(size.width/2, size.height/2);
    [[self _nek_alertLabel] setFrame:frame];
}

- (void)setAlertLabelTintColor:(UIColor *)color
{
    [self _nek_set_alert_label_color:color];
    [[self _nek_alertLabel] setTextColor:color];
}

- (void)setAlertBackgroundTintColor:(UIColor *)color
{
    [self _nek_set_alert_background_color:color];
    [[self _nek_simpleAlertView] setBackgroundColor:color];
    [[self _nek_detailAlertView] setBackgroundColor:color];
}

- (void)showAlert
{
    [[self _nek_simpleAlertView] setHidden:NO];
    [[self _nek_detailAlertView] setHidden:YES];
}

- (void)showAlertWithCount:(NSInteger)count
{
    [[self _nek_simpleAlertView] setHidden:YES];
    [[self _nek_detailAlertView] setHidden:NO];
    [self _nek_setAlertLabelTextWithCount:count];
}

- (void)hideAlert
{
    [[self _nek_simpleAlertView] setHidden:YES];
    [[self _nek_detailAlertView] setHidden:YES];
}

#pragma mark - private methods

- (UIImageView *)_nek_detailAlertView
{
    UIImageView* retView = objc_getAssociatedObject(self, kNEK_BigCircleImageView);
    if (!retView) {
        retView = [self _nek_circleImageViewWithWidth:kNEK_BigCircleImageView_DefaultSize];
        [retView addSubview:[self _nek_alertLabel]];
        [self addSubview:retView];
        [self bringSubviewToFront:retView];
        objc_setAssociatedObject(self, kNEK_BigCircleImageView, retView, OBJC_ASSOCIATION_RETAIN);
    }
    
    return retView;
}

- (UIImageView *)_nek_simpleAlertView
{
    UIImageView* retView = objc_getAssociatedObject(self, kNEK_LittleCircleImageView);
    if (!retView) {
        retView = [self _nek_circleImageViewWithWidth:kNEK_LittleCircleImageView_DefaultSize];
        [self addSubview:retView];
        [self bringSubviewToFront:retView];
        objc_setAssociatedObject(self, kNEK_LittleCircleImageView, retView, OBJC_ASSOCIATION_RETAIN);
    }
    
    return retView;
}

- (UIImageView *)_nek_circleImageViewWithWidth:(CGFloat)width
{
    CGPoint origin = [self _nek_alert_center];
    if (CGPointEqualToPoint(origin, CGPointZero)) {
        origin = CGPointMake((self.frame.size.width - width/2), - width/2);
    }
    
    UIImageView* retView = [[UIImageView alloc] initWithFrame:CGRectMake(origin.x, origin.y, width, width)];
    [retView setHidden:YES];
    [retView setClipsToBounds:YES];
    [retView.layer setCornerRadius:(retView.frame.size.width * 1.0f/2)];
    [retView setBackgroundColor:([self _nek_alert_background_color] ? : [UIColor redColor])];
    
    return retView;
}

- (UILabel *)_nek_alertLabel
{
    UILabel* retLabel = objc_getAssociatedObject(self, kNEK_AlertLabel);
    if (!retLabel) {
        retLabel = [[UILabel alloc] init];
        [retLabel setTextColor:([self _nek_alert_label_color] ? : [UIColor whiteColor])];
        objc_setAssociatedObject(self, kNEK_AlertLabel, retLabel, OBJC_ASSOCIATION_RETAIN);
    }
    
    return retLabel;
}

- (void)_nek_setAlertLabelTextWithCount:(NSInteger)count
{
    UILabel* label = [self _nek_alertLabel];
    
    // label text
    NSString* text = [@(count) stringValue];
    if (count > 99) {
        text = @"99+";
    }
    
    [label setText:text];
    [label setFont:[UIFont systemFontOfSize:kNEK_AlertLabelFontSize]];
    
    // label frame
    CGRect frame = label.frame;
    frame.size = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kNEK_AlertLabelFontSize]}];
    CGSize bgSize = [self _nek_detailAlertView].frame.size;
    frame.origin = CGPointMake((bgSize.width-frame.size.width)/2, (bgSize.height-frame.size.height)/2);
    [label setFrame:frame];
}

- (CGPoint)_nek_alert_center
{
    NSNumber* origin_x = objc_getAssociatedObject(self, kNEK_AlertPoint_X);
    NSNumber* origin_y = objc_getAssociatedObject(self, kNEK_AlertPoint_Y);
    
    return CGPointMake(origin_x.floatValue, origin_y.floatValue);
}

- (void)_nek_set_alert_center:(CGPoint)point
{
    objc_setAssociatedObject(self, kNEK_AlertPoint_X, @(point.x), OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, kNEK_AlertPoint_Y, @(point.y), OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)_nek_alert_label_color
{
    return objc_getAssociatedObject(self, kNEK_Alert_LabelColor);
}

- (void)_nek_set_alert_label_color:(UIColor *)color
{
    objc_setAssociatedObject(self, kNEK_Alert_LabelColor, color, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)_nek_alert_background_color
{
    return objc_getAssociatedObject(self, kNEK_Alert_BackgroundColor);
}

- (void)_nek_set_alert_background_color:(UIColor *)color
{
    objc_setAssociatedObject(self, kNEK_Alert_BackgroundColor, color, OBJC_ASSOCIATION_RETAIN);
}

@end
