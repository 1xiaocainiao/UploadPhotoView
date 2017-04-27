//
//  ImageManager.m
//  YuZhongLib
//
//  Created by xxf on 15/1/15.
//  Copyright (c) 2015年 Kalach. All rights reserved.
//

#import "ImageManager.h"

@implementation ImageManager


+(NSString *)getCachesDir
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}


+(BOOL)isImageExit:(NSString *)url
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *documentsDirectory=[self getCachesDir];
    
    NSString *fullPath=[documentsDirectory stringByAppendingPathComponent:[url lastPathComponent]];
    
    //NSLog(@"%@ 实际路径",fullPath);
    
    return [fileManager fileExistsAtPath:fullPath];
}

+(void)saveThumbnailsImage:(UIImage *)image imageName:(NSString *)url withSize:(CGSize)scaleSize
{
    NSString *fileExtension=[url pathExtension];
    
    NSData *imageData;
    image = [ImageManager scaleImage:image withSize:scaleSize];
    if([[fileExtension lowercaseString] isEqualToString:@"jpg"])
    {
        imageData=UIImageJPEGRepresentation(image, 0.5);
    }
    else
    {
        imageData=UIImagePNGRepresentation(image);
    }
    
    if(imageData)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *documentsDirectory=[self getCachesDir];
        
        NSString *thumbnailsPath = [documentsDirectory stringByAppendingPathComponent:@"thumbnails"];
        
        if ([fileManager fileExistsAtPath:thumbnailsPath])
        {
            //            NSLog(@"success");
        }
        else
        {
            if ([fileManager  createDirectoryAtPath:thumbnailsPath
                        withIntermediateDirectories:YES
                                         attributes:nil
                                              error:nil])
            {
                //                NSLog(@"success");
            }
        }
        
        NSString *fullPath=[documentsDirectory stringByAppendingPathComponent:
                            [NSString stringWithFormat:@"thumbnails/%@",[url lastPathComponent]]];
        
        [fileManager createFileAtPath:fullPath contents:imageData attributes:nil];
        
        //NSLog(@"%@ 保存成功",p);
    }

}

+(void)saveImage:(UIImage *)image imageName:(NSString *)url
{
    NSString *fileExtension=[url pathExtension];
    
    NSData *imageData;
    if([[fileExtension lowercaseString] isEqualToString:@"jpg"])
    {
        imageData=UIImageJPEGRepresentation(image, 0.5);
    }
    else
    {
        imageData=UIImagePNGRepresentation(image);
    }
    
    if(imageData)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *documentsDirectory=[self getCachesDir];
        
        NSString *fullPath=[documentsDirectory stringByAppendingPathComponent:[url lastPathComponent]];
        
        [fileManager createFileAtPath:fullPath contents:imageData attributes:nil];
        
        //NSLog(@"%@ 保存成功",p);
    }

}

+(UIImage *)getThumbnailsImageWithImageName:(NSString *)url
{
    NSString *documentsDirectory=[self getCachesDir];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *thumbnailsPath = [documentsDirectory stringByAppendingPathComponent:@"thumbnails"];
    
    if ([fileManager fileExistsAtPath:thumbnailsPath])
    {
        //            NSLog(@"success");
    }
    else
    {
        if ([fileManager  createDirectoryAtPath:thumbnailsPath
                    withIntermediateDirectories:YES
                                     attributes:nil
                                          error:nil])
        {
            //                NSLog(@"success");
        }
    }
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"thumbnails/%@",[url lastPathComponent]]];
    
    return [UIImage imageWithContentsOfFile:fullPath];

}

+(UIImage *)getImageWithImageName:(NSString *)url
{
    NSString *documentsDirectory=[self getCachesDir];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[url lastPathComponent]];
    
    return [UIImage imageWithContentsOfFile:fullPath];
}
+(NSString *)getImagePathWithImageName:(NSString *)url
{
    NSString *documentsDirectory=[self getCachesDir];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[url lastPathComponent]];
    return fullPath;
}

+(void)removeThunbanisImageWithImageName:(NSString *)url
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *documentsDirectory=[self getCachesDir];
    
    NSString *thumbnailsPath = [documentsDirectory stringByAppendingPathComponent:@"thumbnails"];
    
    if ([fileManager fileExistsAtPath:thumbnailsPath])
    {
        //            NSLog(@"success");
    }
    else
    {
        if ([fileManager  createDirectoryAtPath:thumbnailsPath
                    withIntermediateDirectories:YES
                                     attributes:nil
                                          error:nil])
        {
            //                NSLog(@"success");
        }
    }
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"thumbnails/%@",[url lastPathComponent]]];
    
    NSError *error = nil;
    
    BOOL reg = [fileManager removeItemAtPath: fullPath error:&error];
    
    if (!reg)
    {
        NSLog(@"%@",error);
    }

}

+(void)removeImageWihtImageName:(NSString *)url
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *documentsDirectory=[self getCachesDir];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[url lastPathComponent]];
    
    NSError *error = nil;
    
    BOOL reg = [fileManager removeItemAtPath: fullPath error:&error];
    
    if (!reg)
    {
        NSLog(@"%@",error);
    }
}

//等比切图
+ (UIImage *)screenshot:(CGSize)size withImage:(UIImage *)image
{
    CGFloat width = CGImageGetWidth(image.CGImage);
    CGFloat height = CGImageGetHeight(image.CGImage);
    
    float radio = size.width/size.height;
    float xPos;
    float yPos;
    if (width/height >=radio)
    {
        xPos = (width - height*radio)/2;
        width = height*radio;
        yPos = 0;
        
    }
    else
    {
        xPos = 0;
        yPos= (height - width/radio)/2;
        height = width/radio;
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(xPos, yPos, width, height));
    
    UIImage *newImage = [self scaleImage:[UIImage imageWithCGImage:imageRef] withSize:size];
    
    CGImageRelease(imageRef);
    
    return newImage;
}

+ (UIImage *)scaleImage:(UIImage *)image withSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    int w = image.size.width;
    int h = image.size.height;
    int scaleWidth = 0;
    int scaleHeight = 0;
    if(w>h)
    {
        scaleWidth = size.width;
        scaleHeight = h/(w/size.width);
    }else{
        scaleHeight = size.width;
        scaleWidth = w/(h/size.width);
    }
    UIGraphicsBeginImageContext(CGSizeMake(scaleWidth,scaleHeight));
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, scaleWidth, scaleHeight)];

    // 从当前context中创建一个改变大小后的图片
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}


+(UIImage *)fixOrientation:(UIImage *)aImage
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    
    //两种都可以画圆，第一种画边框有锯齿，第二种暂时没找到方法画边框，个人喜欢第二种
    
//    UIGraphicsBeginImageContext(image.size);
//    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
//    
//    CGContextRef context =UIGraphicsGetCurrentContext();
//    
//    //圆的边框宽度为2，颜色为红色
//    
//    CGContextSetLineWidth(context,2);
//    CGContextSetShouldAntialias(context, NO);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
//    
//    CGRect rect = CGRectMake(inset, inset, image.size.width - inset *2.0f, image.size.height - inset *2.0f);
//    
//    CGContextAddEllipseInRect(context, rect);
//    
//    CGContextClip(context);
//    
//    //在圆区域内画出image原图
//    
//    [image drawInRect:rect];
//    
//    CGContextAddEllipseInRect(context, rect);
//    
//    CGContextStrokePath(context);
//    
//    //生成新的image
//    
//    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
    
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 1.0);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
     
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height)
                                                    cornerRadius:image.size.height/2.0];
    [path addClip];
    
    // Draw your image
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    // Get the image, here setting the UIImageView image
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return newimg;
    
}

+ (UIImage *)getRoundedRectImageFromImage:(UIImage *)image imageView:(UIImageView*)imageView withCornerRadius :(float)cornerRadius roundingCorners:(UIRectCorner)corners {
    CGSize size = imageView.bounds.size;
    
    int w = image.size.width;
    int h = image.size.height;
    
    int scaleWidth = 0;
    int scaleHeight = 0;
    
    CGFloat orginX = 0;
    CGFloat orginY = 0;
    
    if(w>h)
    {
        scaleWidth = size.width;
        scaleHeight = h/(w/size.width);
        
        orginX = 0;
        
        orginY = (size.height - scaleHeight) / 2.0;
    } else if (w == h) {
        scaleHeight = size.width;
        scaleWidth = size.height;
        
        orginX = 0;
        
        orginY = 0;
    } else {
        scaleHeight = size.width;
        scaleWidth = w/(h/size.width);
        
        orginX = (size.width - scaleWidth) / 2.0;
        
        orginY = 0;
    }
    
    
    CGRect newRect = CGRectMake(orginX, orginY, scaleWidth, scaleHeight);
    
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners: corners cornerRadii:CGSizeMake(cornerRadius,cornerRadius)] addClip];
    
    [image drawInRect:newRect];
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
}



@end
