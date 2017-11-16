//
//  ImageMasaicTool.m
//  OpenCV_Mosaic
//
//  Created by junde on 2017/11/15.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "ImageMasaicTool.h"
// 导入OpenCV框架
//核心头文件
#import <opencv2/opencv.hpp>
//对iOS支持
#import <opencv2/imgcodecs/ios.h>
//导入矩阵帮助类
#import <opencv2/highgui.hpp>
#import <opencv2/core/types.hpp>
// 导入C++命名空间
using namespace cv;

@implementation ImageMasaicTool

+ (UIImage *)opencvImage:(UIImage *)image level:(int)level {
    // 实现功能
    // 第一步: 将iOS图片 ->OpenCV图片(Mat矩阵)
    Mat mat_image_src;
    UIImageToMat(image, mat_image_src);
    
    // 第二步: 确定宽高, 并将图片进行颜色空间转换
    int width = mat_image_src.cols;
    int height = mat_image_src.rows;
    
    // 图片类型转换
    // opencv官网中,里面进行图处理的时候,规律-> 每次都会调用cvtColor保持一致(RGB)
    // 因为OpenCV里面只支持RGB的颜色空间处理,而图片是ARGB的颜色空间,所以每次处理的时候一定要记得类型转换
    Mat mat_image_dst;
    cvtColor(mat_image_src, mat_image_dst, CV_RGBA2RGB, 3);
    
    // 为了不影响原始图片,克隆一张
    Mat mat_image_clone = mat_image_dst.clone();
    
    // 第三步: 马赛克处理
    // 分析马赛克算法原理
    // 如果 level = 3 -> 3 * 3矩形 内有9个像素点
    // 动态处理
    int x = width - level;
    int y = height - level;
    
    for (int i = 0; i < y; i += level) {
        for (int j = 0; j < x; j += level) {
         
            // 循环取出需要处理的矩形区域
            Rect2i mosaicRect = Rect2i(j, i, level, level);
            // 给Rect2i区域 -> 填充数据 -> 原始数据
            Mat roi = mat_image_dst(mosaicRect);
            
            // 让整个矩形区域颜色保持一致 可以理解为矩形区域内每个像素点颜色一致
            // mat_image_clone.at<Vec3b>(i, j) -> 像素点(颜色组成值->多个) -> ARGB -> 数组
            // mat_image_clone.at<Vec3b>(i, j)[0] -> R值
            // mat_image_clone.at<Vec3b>(i, j)[1] -> G值
            // mat_image_clone.at<Vec3b>(i, j)[2] -> B值
            Scalar scalar = Scalar(
                                   mat_image_clone.at<Vec3b>(i, j)[0],
                                   mat_image_clone.at<Vec3b>(i, j)[1],
                                   mat_image_clone.at<Vec3b>(i, j)[2]
                                   );
            
            // 将处理好的矩形区域 -> 数据 -> 拷贝到图片上去 -> 修改后的数据
            // CV_8UC3含义:
            // CV_: 表示框架命名空间
            // 8: 表示32位色 -> ARGB -> 8位 = 1字节 -> 4个字节
            // U: 表示无符号类型
            //    两种类型：有符号类型(Sign->有正负->简写"S")、无符号类型(Unsign->正数->"U")
            //    无符号类型：0-255(通常情况)
            //    有符号类型：-128-127
            // C: 表示 char 类型
            // 3: 表示 3个通道 -> RGB
            Mat roiCopy = Mat(mosaicRect.size(), CV_8UC3, scalar);
            roiCopy.copyTo(roi);
        }
    }
    
    // 第四步: 将OpenCV图片 -> iOS图片
    return MatToUIImage(mat_image_dst);
}

@end
