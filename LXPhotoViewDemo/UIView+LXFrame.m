//
//  UIView+LXFrame.m
//  Yianke
//
//  Created by xxf on 16/12/28.
//  Copyright © 2016年 suokeer. All rights reserved.
//

#import "UIView+LXFrame.h"

@implementation UIView (LXFrame)

- (CGFloat)lx_top
{
    return self.frame.origin.y;
}

- (void)setLx_top:(CGFloat)lx_top
{
    CGRect frame = self.frame;
    frame.origin.y = lx_top;
    self.frame = frame;
}

- (CGFloat)lx_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLx_right:(CGFloat)lx_right
{
    CGRect frame = self.frame;
    frame.origin.x = lx_right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)lx_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLx_bottom:(CGFloat)lx_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = lx_bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)lx_left
{
    return self.frame.origin.x;
}

- (void)setLx_left:(CGFloat)lx_left
{
    CGRect frame = self.frame;
    frame.origin.x = lx_left;
    self.frame = frame;
}

- (CGFloat)lx_width
{
    return self.frame.size.width;
}

- (void)setLx_width:(CGFloat)lx_width
{
    CGRect frame = self.frame;
    frame.size.width = lx_width;
    self.frame = frame;
}

- (CGFloat)lx_height
{
    return self.frame.size.height;
}

- (void)setLx_height:(CGFloat)lx_height
{
    CGRect frame = self.frame;
    frame.size.height = lx_height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)lx_origin {
    return self.frame.origin;
}

- (void)setLx_origin:(CGPoint)lx_origin {
    CGRect frame = self.frame;
    frame.origin = lx_origin;
    self.frame = frame;
}

- (CGSize)lx_size {
    return self.frame.size;
}

- (void)setLx_size:(CGSize)lx_size {
    CGRect frame = self.frame;
    frame.size = lx_size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)lx_centerH {
    return self.center.x;
}

- (void)setLx_centerH:(CGFloat)lx_centerH {
    self.center = CGPointMake(lx_centerH, self.center.y);
}

- (CGFloat)lx_centerV {
    return self.center.y;
}

- (void)setLx_centerV:(CGFloat)lx_centerV {
    self.center = CGPointMake(self.center.x, lx_centerV);
}


#pragma mark - 分割线

+ (CGSize)lx_viewSize {
    return CGSizeZero;
}




@end
