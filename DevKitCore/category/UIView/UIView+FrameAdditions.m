//
//  UIView+FrameAdditions.m
//  mail
//
//  Created by sddz_yuxiaohua on 14-5-6.
//  Copyright © 2015年 X Co., Ltd. All rights reserved.
//

#import "UIView+FrameAdditions.h"

@implementation UIView (FrameAdditions)
- (CGPoint)origin { return self.frame.origin; }
- (void)setOrigin:(CGPoint)origin { self.frame = (CGRect){ .origin=origin, .size=self.frame.size }; }

- (CGFloat)x { return self.frame.origin.x; }
- (void)setX:(CGFloat)x { self.frame = (CGRect){ .origin.x=x, .origin.y=self.frame.origin.y, .size=self.frame.size }; }
- (CGFloat)maxX{
    return self.x + self.width;
}

- (CGFloat)y { return self.frame.origin.y; }
- (void)setY:(CGFloat)y { self.frame = (CGRect){ .origin.x=self.frame.origin.x, .origin.y=y, .size=self.frame.size }; }
- (CGFloat)maxY{
    return self.y + self.height;
}

- (CGSize)size { return self.frame.size; }
- (void)setSize:(CGSize)size { self.frame = (CGRect){ .origin=self.frame.origin, .size=size }; }

- (CGFloat)width { return self.frame.size.width; }
- (void)setWidth:(CGFloat)width { self.frame = (CGRect){ .origin=self.frame.origin, .size.width=width, .size.height=self.frame.size.height }; }

- (CGFloat)height { return self.frame.size.height; }
- (void)setHeight:(CGFloat)height { self.frame = (CGRect){ .origin=self.frame.origin, .size.width=self.frame.size.width, .size.height=height }; }

- (CGFloat)left { return self.frame.origin.x; }
- (void)setLeft:(CGFloat)left { self.frame = (CGRect){ .origin.x=left, .origin.y=self.frame.origin.y, .size.width=fmaxf(self.frame.origin.x+self.frame.size.width-left,0), .size.height=self.frame.size.height }; }

- (CGFloat)top { return self.frame.origin.y; }
- (void)setTop:(CGFloat)top { self.frame = (CGRect){ .origin.x=self.frame.origin.x, .origin.y=top, .size.width=self.frame.size.width, .size.height=fmaxf(self.frame.origin.y+self.frame.size.height-top,0) }; }

- (CGFloat)right { return self.frame.origin.x + self.frame.size.width; }
- (void)setRight:(CGFloat)right { self.frame = (CGRect){ .origin=self.frame.origin, .size.width=fmaxf(right-self.frame.origin.x,0), .size.height=self.frame.size.height }; }

- (CGFloat)bottom { return self.frame.origin.y + self.frame.size.height; }
- (void)setBottom:(CGFloat)bottom { self.frame = (CGRect){ .origin=self.frame.origin, .size.width=self.frame.size.width, .size.height=fmaxf(bottom-self.frame.origin.y,0) }; }

- (void)removeAllSubviews
{
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

-(CGFloat)centerX{
    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.center.y);
}

-(CGFloat)centerY{
    return self.center.y;
}

-(void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.center.x, centerY);
}

+ (id)getViewFromXib:(NSString *)name owner:(id)owner
{
    id view = [[NSBundle mainBundle] loadNibNamed:name owner:owner options:nil][0];
    return view;
}

+ (id)getViewFromXib:(NSString *)name owner:(id)owner tag:(NSInteger)tag
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:name owner:owner options:nil];
    for(UIView *view in views) {
        if (view.tag == tag) {
            return view;
        }
    }
    return nil;
}


- (UIImage *)getCaptureImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    // Get the snapshot
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

- (UIColor *) colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

@end
