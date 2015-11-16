//
//  UIImageView+Animation.m
//  NEDevKit
//
//  Created by sddz_yuxiaohua on 15/10/15.
//
//

#import "UIImageView+Animation.h"

#import <objc/runtime.h>

typedef void(^NEK_FinishBlock)();

static void const *kNEK_ImageView_Animation1_FinishBlock = &kNEK_ImageView_Animation1_FinishBlock;
static void const *kNEK_ImageView_Animation1_IsAnimationRunning = &kNEK_ImageView_Animation1_IsAnimationRunning;

@implementation UIImageView (Animation)

- (void)animateWithPattern:(NSString *)pattern frames:(NSInteger)frames
{
    return [self animateWithPattern:pattern frames:frames repeatCount:INFINITY reverse:NO finish:NULL];
}

- (void)animateWithPattern:(NSString *)pattern frames:(NSInteger)frames reverse:(BOOL)isReverse
{
    return [self animateWithPattern:pattern frames:frames repeatCount:INFINITY reverse:isReverse finish:NULL];
}

- (void)animateWithPattern:(NSString *)pattern
                    frames:(NSInteger)frames
               repeatCount:(NSInteger)repeatCount
                   reverse:(BOOL)isReverse
                    finish:(void (^)())finish
{
    assert(frames > 0 && repeatCount >= 0);
    
    [self stopAnimating];
    
    // copy finish block
    [self _nek_copy_finish_block:finish];
    
    // generate image frames
    NSMutableArray* images = [NSMutableArray arrayWithCapacity:frames];
    for (NSInteger idx = 1; idx <= frames; idx ++) {
        NSString* image_name = [NSString stringWithFormat:pattern, idx];
        UIImage* image = [UIImage imageNamed:image_name];
        if (image) [images addObject:image];
    }
    
    // first frame
    UIImage* first_image_frame = images.firstObject;
    
    // whether reverse animation
    if (isReverse) {
        first_image_frame = images.lastObject;
        images = [[[images reverseObjectEnumerator] allObjects] mutableCopy];
    }
    
    [self setImage:first_image_frame];
    [self setAnimationImages:images];
    [self setAnimationDuration:frames/30.0f];
    [self setAnimationRepeatCount:repeatCount];
    
    // start animation
    [self _nek_startAnimation];
}

#pragma mark - private methods

- (void)_nek_startAnimation
{
    [CATransaction begin];
    __weak __typeof(self) weakself = self;
    [CATransaction setCompletionBlock:^{
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        if (state != UIApplicationStateActive) {
            return;
        }
        
        NEK_FinishBlock finish = [weakself _nek_finish_block];
        if (finish) finish();
        [weakself _nek_set_is_animation_running:NO];
        [weakself _nek_uninstall_basic_notification];
    }];
    
    [self startAnimating];
    [self _nek_set_is_animation_running:YES];
    [self _nek_install_basic_notification];
    [CATransaction commit];
}

- (void)_nek_install_basic_notification
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [center addObserver:self selector:@selector(_nek_restart_animation_if_need)
                   name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)_nek_uninstall_basic_notification
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (NEK_FinishBlock)_nek_finish_block
{
    return objc_getAssociatedObject(self, kNEK_ImageView_Animation1_FinishBlock);
}

- (void)_nek_copy_finish_block:(NEK_FinishBlock)block
{
    objc_setAssociatedObject(self, kNEK_ImageView_Animation1_FinishBlock, block, OBJC_ASSOCIATION_COPY);
}

- (BOOL)_nek_is_animation_running
{
    NSNumber* isRunning = objc_getAssociatedObject(self, kNEK_ImageView_Animation1_IsAnimationRunning);
    return [isRunning boolValue];
}

- (void)_nek_set_is_animation_running:(BOOL)isRunning
{
    objc_setAssociatedObject(self,
                             kNEK_ImageView_Animation1_IsAnimationRunning,
                             @(isRunning),
                             OBJC_ASSOCIATION_RETAIN);
}

- (void)_nek_restart_animation_if_need
{
    if (![self _nek_is_animation_running]) {
        return;
    }
    
    [self _nek_startAnimation];
}

@end
