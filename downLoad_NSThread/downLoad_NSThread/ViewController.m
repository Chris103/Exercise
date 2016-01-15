//
//  ViewController.m
//  downLoad_NSThread
//
//  Created by sean on 16/1/16.
//  Copyright © 2016年 usean. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 开一个线程
    [NSThread detachNewThreadSelector:@selector(downLoadPic2) toTarget:self withObject:nil];
}

/**
 *  下载图片
 */
- (void)downLoadPic
{
    // 获得当前时间
    CFTimeInterval start = CFAbsoluteTimeGetCurrent();
//    下载图片
    NSURL *url = [NSURL URLWithString:@"http://p3.music.126.net/e_Sul6TN5TJ5b9BdYbFKng==/3263350511391851.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    NSLog(@"%f",end - start);
    
    // 在 UI 线程设置图片
    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:[UIImage imageWithData:data] waitUntilDone:YES];
}

- (void)downLoadPic2
{
    NSDate *start = [NSDate date];
    
    NSURL *url = [NSURL URLWithString:@"http://p3.music.126.net/e_Sul6TN5TJ5b9BdYbFKng==/3263350511391851.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDate *end = [NSDate date];
    UIImage *image = [UIImage imageWithData:data];
    NSLog(@"%f",[end timeIntervalSinceDate:start]);
    
    [self performSelector:@selector(showImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
}

- (void)showImage:(UIImage *)image
{
    self.imageView.image = image;
}
@end
