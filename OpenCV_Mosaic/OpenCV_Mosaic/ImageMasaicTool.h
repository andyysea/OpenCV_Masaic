//
//  ImageMasaicTool.h
//  OpenCV_Mosaic
//
//  Created by junde on 2017/11/15.
//  Copyright © 2017年 junde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageMasaicTool : NSObject



/**
 定义一个图片的打码处理方法

 @param image 传入需要打码的图片
 @param level 打码级别,表示原图中每几个像素变成新图里面的一个像素
 @return 返回打上马赛克的图片
 */
+ (UIImage *)opencvImage:(UIImage *)image level:(int)level;

@end
