//
//  ViewController.m
//  GCD__异步函数
//
//  Created by sean on 16/1/20.
//  Copyright © 2016年 usean. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //异步函数 + 主队列
//    [self asyncMain];
    
    // 异步函数 + 串行队列
//    [self asyncSerial];
    
    // 异步函数 + 全局并发队列
//    [self asyncGlobal];
    
    // 异步函数 + 并发队列
    [self asyncConrrent];
    
}

/**
 *  主队列 + 异步函 数不会开启新线程 在主线程中执行任务
 */
- (void)asyncMain
{
    NSLog(@"begin---");
    // 获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    //添加任务给主队列
    dispatch_async(queue, ^{
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"3----%@",[NSThread currentThread]);
    });
    
    NSLog(@"---end");
}

/**
 *  串行队列 + 异步函数 会开启串行队列 在串行队列中串行执行任务
 */
- (void)asyncSerial
{
    NSLog(@"begin---");
    // 创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("串行队列", DISPATCH_QUEUE_SERIAL);
    
    // 添加任务到队列中
    dispatch_async(queue, ^{
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    
    NSLog(@"---end");
}

/**
 *  异步函数 + 全局并发队列 开启新线程并行执行
 */
- (void)asyncGlobal
{
    NSLog(@"begin---");
    // 获得全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 添加任务给队列
    dispatch_async(queue, ^{
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    NSLog(@"---end");
}




/**
 *  异步函数 + 并发队列 开启新线程  并行执行
 */
- (void)asyncConrrent
{
    NSLog(@"begin---");
    // 创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    // 添加任务到队列
    dispatch_async_f(queue, nil, logNum1);
    dispatch_async_f(queue, nil, logNum2);
    dispatch_async_f(queue, nil, logNum3);
    
    NSLog(@"---end");
}


void logNum1()
{
    for (NSInteger i = 0; i < 100; i ++) {
        NSLog(@"1--%zd-%@",i,[NSThread currentThread]);
    }
}

void logNum2()
{
    for (NSInteger i = 0; i < 100; i ++) {
        NSLog(@"2--%zd-%@",i,[NSThread currentThread]);
    }
}
void logNum3()
{
    for (NSInteger i = 0; i < 100; i ++) {
        NSLog(@"3--%zd-%@",i,[NSThread currentThread]);
    }
}



@end
