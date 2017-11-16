//
//  ViewController.m
//  OpenCV_Mosaic
//
//  Created by junde on 2017/11/15.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "ViewController.h"
#import "ImageMasaicTool.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/** 给图片打码 */
- (IBAction)convertMosaicImageClick:(id)sender {
    self.imageView.image = [ImageMasaicTool opencvImage:_imageView.image level:20];
}

/** 图片还原 */
- (IBAction)convertNormalImageClick:(id)sender {
    self.imageView.image = [UIImage imageNamed:@"Test.jpeg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
