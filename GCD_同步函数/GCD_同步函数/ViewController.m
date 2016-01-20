//
//  ViewController.m
//  GCD_同步函数
//
//  Created by sean on 16/1/20.
//  Copyright © 2016年 usean. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 主队列 + 同步函数
    [self syncMain];
    
    // 串行队列 +同步函数
//    [self syncMain2];
    
    // 全局并发队列 + 同步函数
    [self syncConcurrent];
    
    NSLog(@"end");
}

/**
 *  主队列 + 同步函数
 */
- (void)syncMain
{
    // 主队列 + 同步函数 会出现堵塞
      NSLog(@"syncMain ----- begin");
    // 获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 将任务加入队列
    dispatch_sync( queue, ^{
        NSLog(@"%@----",[NSThread currentThread]);
    });
    
    dispatch_sync( queue, ^{
        NSLog(@"%@----",[NSThread currentThread]);
    });
    dispatch_sync( queue, ^{
        NSLog(@"%@----",[NSThread currentThread]);
    });
    
        NSLog(@"syncMain ----- end");
}

/**
 *  串行队列 +同步函数
 */
- (void)syncMain2
{
//    不会开启新的线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务
    
    NSLog(@"syncMain ----- begin");
    // 创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("net.usean", DISPATCH_QUEUE_SERIAL);
    
    // 将任务加入队列
    dispatch_sync(queue, ^{
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"3----%@",[NSThread currentThread]);
    });
    
     NSLog(@"syncMain ----- end");
}

/**
 *   同步函数 + 全局并发队列
 */
- (void)syncConcurrent
{
    // 因为是同步函数 ,所以不会开启新线程
    NSLog(@"syncMain ----- begin");
    // 创建全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    // 添加任务到队列
    dispatch_sync(queue, ^{
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    
     NSLog(@"syncMain ----- end");
    
}
@end
