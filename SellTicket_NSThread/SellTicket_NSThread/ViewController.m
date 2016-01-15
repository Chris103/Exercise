//
//  ViewController.m
//  SellTicket_NSThread
//
//  Created by sean on 16/1/15.
//  Copyright © 2016年 usean. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSThread *seller00;
@property (strong, nonatomic) NSThread *seller01;
@property (strong, nonatomic) NSThread *seller02;
@property (strong, nonatomic) NSThread *seller03;
/**
 *  余票
 */
@property ( assign, nonatomic) NSInteger tickets;

/**
 *  锁对象
 */
@property (strong, nonatomic) NSObject *locker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tickets = 10;
    // 实例化所对象
    self.locker = [[NSObject alloc] init];
    
    // 创建线程
    self.seller00 = [[NSThread alloc] initWithTarget:self selector:@selector(scaleTicket) object:nil];
    self.seller00.name = @"Thread 00";
    self.seller01 = [[NSThread alloc] initWithTarget:self selector:@selector(scaleTicket) object:nil];
    self.seller01.name = @"Thread 01";
    self.seller02 = [[NSThread alloc] initWithTarget:self selector:@selector(scaleTicket) object:nil];
    self.seller02.name = @"Thread 02";
    self.seller03 = [[NSThread alloc] initWithTarget:self selector:@selector(scaleTicket) object:nil];
    self.seller03.name = @"Thread 03";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.seller00 start];
    [self.seller01 start];
    [self.seller02 start];
    [self.seller03 start];
    
}

- (void)scaleTicket
{
    NSLog(@"%@开始买票",[NSThread currentThread].name);
    
    // 循环卖票
    while (true) {
        // 加互斥锁
        @synchronized(self.locker){
        if(self.tickets >0){
            self.tickets --;
            NSLog(@"%@---还剩%zd 张票",[NSThread currentThread].name,self.tickets);
        }else{
            NSLog(@"%@:票卖完了",[NSThread currentThread].name);
            break;
        }
    }
    }
}
@end
