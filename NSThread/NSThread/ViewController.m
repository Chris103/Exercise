//
//  ViewController.m
//  NSThread
//
//  Created by sean on 16/1/15.
//  Copyright © 2016年 usean. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 线程一启动 就会调用线程 thread 中的 doSomething 方法
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething1) object:nil];
    thread1.name = @"thread1";
    // 启动线程
    [thread1 start];
    
    // 创建匿名线程并启动
    [NSThread detachNewThreadSelector:@selector(doSomething2) toTarget:self withObject:nil];
    
    // 隐式创建线程
    [self performSelectorInBackground:@selector(doSomething3) withObject:nil];
    
    
    
}

- (void)doSomething1
{
    NSLog(@"doSomething1---%@",[NSThread currentThread]);
    
    // 将线程阻塞
    [NSThread sleepForTimeInterval:2.0];
    // 获取时间
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:5.0];
    
    for (NSInteger i = 0; i < 10; i ++) {
        // 阻塞线程
        [NSThread sleepUntilDate:date];
        NSLog(@"%zd",i);
        
        if (5 == i) {
            // 结束线程
            [NSThread exit];
        }
    }
}

- (void)doSomething2
{
    NSLog(@"doSomething2---%@",[NSThread currentThread]);
}
- (void)doSomething3
{
    NSLog(@"doSomething3---%@",[NSThread currentThread]);
}

@end
