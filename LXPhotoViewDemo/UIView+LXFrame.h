//
//  UIView+LXFrame.h
//  Yianke
//
//  Created by xxf on 16/12/28.
//  Copyright © 2016年 suokeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LXFrame)

@property (nonatomic, assign) CGPoint lx_origin;
@property (nonatomic, assign) CGSize lx_size;

// shortcuts for positions
@property (nonatomic) CGFloat lx_centerH;
@property (nonatomic) CGFloat lx_centerV;


@property (nonatomic) CGFloat lx_top;
@property (nonatomic) CGFloat lx_bottom;
@property (nonatomic) CGFloat lx_right;
@property (nonatomic) CGFloat lx_left;

@property (nonatomic) CGFloat lx_width;
@property (nonatomic) CGFloat lx_height;


/**
 自定义view 需要时自定义size 重写
 */
+ (CGSize)lx_viewSize;




@end
