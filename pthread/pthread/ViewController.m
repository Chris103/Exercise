//
//  ViewController.m
//  pthread
//
//  Created by sean on 16/1/15.
//  Copyright © 2016年 usean. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  run函数
 *
 *  @param param  参数
 *
 *  @return 指针
 */
void * run(void *param)
{
    for (NSInteger i = 0; i < 10000; i++) {
        NSLog(@"%@",[NSThread currentThread]);
    }
    return NULL;
}


/**
 *  按钮点击事件
 */
- (IBAction)btnDidClick {
    
    // 指向线程的指针
    pthread_t thread;
    // 创建 pthread
    pthread_create(&thread, NULL, run, NULL);
}



@end
