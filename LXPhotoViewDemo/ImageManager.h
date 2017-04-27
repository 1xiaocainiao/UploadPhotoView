//
//  ImageManager.h
//  YuZhongLib
//
//  Created by xxf on 15/1/15.
//  Copyright (c) 2015年 Kalach. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface ImageManager : NSObject

+(BOOL)isImageExit:(NSString *)url;

+(void)saveThumbnailsImage:(UIImage *)image imageName:(NSString *)url withSize:(CGSize)scaleSize;

+(void)saveImage:(UIImage *)image imageName:(NSString *)url;

+(UIImage *)getThumbnailsImageWithImageName:(NSString *)url;

+(UIImage *)getImageWithImageName:(NSString *)url;

+(NSString *)getImagePathWithImageName:(NSString *)url;

+(void)removeThunbanisImageWithImageName:(NSString *)url;

+(void)removeImageWihtImageName:(NSString *)url;


/**
 *  等比切图
 *
 */
+ (UIImage*)screenshot:(CGSize)size withImage:(UIImage *)image;

+ (UIImage *)scaleImage:(UIImage *)image withSize:(CGSize)size;

/**
 *  缩放到指定宽度
 *
 */
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

//修正图片方向
+(UIImage *)fixOrientation:(UIImage *)aImage;

+(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;


/**
 重绘 带 圆角 的图片

 @param image image description
 @param imageView imageView description
 @param cornerRadius cornerRadius description
 @param corners corners description
 @return return value description
 */
+ (UIImage *)getRoundedRectImageFromImage:(UIImage *)image
                                imageView:(UIImageView*)imageView
                        withCornerRadius :(float)cornerRadius
                          roundingCorners:(UIRectCorner)corners;


@end
