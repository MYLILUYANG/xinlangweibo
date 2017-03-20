//
//  ViewController.m
//  Runloop
//
//  Created by liluyang on 2017/3/16.
//  Copyright © 2017年 liluyang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    NSTimer *timier = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:2 target:self selector:@selector(timierAction) userInfo:nil repeats:YES];
    //只运行defaul 模式 一旦进入其他模式，这个定时器就不会工作。
//    [[NSRunLoop mainRunLoop] addTimer:timier forMode:NSDefaultRunLoopMode];
    //定时器会跑在标记为common modes 模式下,既能defaul  模式下运行，又能 滚动模式下。
    //标记为common modes 的模式tracking 和default
      [[NSRunLoop mainRunLoop] addTimer:timier forMode:NSRunLoopCommonModes];
    */
    
    [self addObserver];
    
}

-(void)addObserver{
    //创建observer
    CFRunLoopObserverRef obser = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        NSLog(@"监听到runloop 发生变化 ---%zd",activity);
        
    });
    //添加观察者，监听runloop 状态
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), obser, kCFRunLoopDefaultMode);
    
    CFRelease(obser);
    
    
    
}

/*
 CF内存管理，（Core Foundation）
 1、 凡是带有creat 。copy retina 等字眼的函数，创建出来的对象，都要在最后做一次release 不如
 */


- (IBAction)touchBtn:(UIButton *)sender {
    NSLog(@"bbb");
//    sources 0
    
}

-(void)timierAction
{
    NSLog(@"aaa");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
