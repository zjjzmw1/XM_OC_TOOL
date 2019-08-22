//
//  XMTimer.h
//  艺库
//
//  Created by zhangmingwei on 2019/8/22.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

/*
 
 // 用法一：
 [[XMTimer defaultManager] xm_scheduleGCDTimerWithName:@"myTime1" interval:1 queue:dispatch_get_main_queue() repeats:YES action:^{
 XMLog(@"当前页面可以正常销毁，但是定时器不会自动销毁，需要手动调用xm_cancel方法");
 }];
 // 用法二：
 self.myTimer = [[XMTimer alloc] init];
 [self.myTimer xm_scheduleGCDTimerWithName:@"myTime2" interval:1 queue:dispatch_get_main_queue() repeats:YES action:^{
 XMLog(@"当前页面可以正常销毁，定时器也会自动销毁");
 }];

 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 好用的定时器 - 修复苹果自带NSTimer循环引用的bug
@interface XMTimer : NSObject

/// !!! --- 不依赖于某一个页面的定时器才需要用单利 --- !!!
/// !!! --- 某个页面销毁，定时器也需要销毁的话，需要添加个XMTimer属性到页面中，用 [[XMTimer alloc] init]，别用单利 --- !!!
+ (XMTimer *)defaultManager;

/**
 启动一个timer (默认精度为0.1s)
 @param timerName       timer的名称，作为唯一标识。
 @param interval        每次执行的时间间隔。
 @param queue           timer将被放入的队列，也就是最终action执行的队列。传入nil将自动放到一个全局子线程队列中。
 @param repeats         timer是否循环调用。
 @param option          多次schedule同一个timer时的操作选项(目前提供将之前的任务废除或合并的选项)。
 @param action          时间间隔到点时执行的block。
 */
- (void)xm_scheduleGCDTimerWithName:(NSString *)timerName
                           interval:(double)interval
                              queue:(dispatch_queue_t)queue
                            repeats:(BOOL)repeats
                             action:(dispatch_block_t)action;

/**
 取消timer
 @param timerName timer的名称，作为唯一标识。
 */
- (void)xm_cancelTimerWithName:(NSString *)timerName;


@end

NS_ASSUME_NONNULL_END
