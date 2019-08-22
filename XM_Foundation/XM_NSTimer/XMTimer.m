//
//  XMTimer.m
//  艺库
//
//  Created by zhangmingwei on 2019/8/22.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMTimer.h"

@interface XMTimer ()

@property (nonatomic, strong) NSMutableDictionary *timerArry;
@property (nonatomic, strong) NSMutableDictionary *timerActionBlockCacheArry;

@end

@implementation XMTimer

/// 小明定时器 单例
+ (XMTimer *)defaultManager {
    static XMTimer *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        manager = [[XMTimer alloc] init];
    });
    return manager;
}

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
                             action:(dispatch_block_t)action {
    if ([NSString isEmptyString:timerName]) {
        return;
    }
    // timer将被放入的队列queue，也就是最终action执行的队列。传入nil将自动放到一个全局子线程队列中
    if (nil == queue) {
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    // 创建dispatch_source_t的timer
    dispatch_source_t timer = [self.timerArry objectForKey:timerName];
    if (nil == timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        [self.timerArry setObject:timer forKey:timerName];
    }
    // 设置首次执行事件、执行间隔和精确度(默认为0.1s)
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    __weak typeof(self) wSelf = self;
    // 移除上一次任务
    [self removeActionCacheForTimer:timerName];
    // 时间间隔到点时执行block
    dispatch_source_set_event_handler(timer, ^{
        action();
        if (!repeats) {
            [wSelf xm_cancelTimerWithName:timerName];
        }
    });
}

/**
 取消timer
 @param timerName timer的名称，作为唯一标识。
 */
- (void)xm_cancelTimerWithName:(NSString *)timerName {
    dispatch_source_t timer = [self.timerArry objectForKey:timerName];
    if (!timer) {
        return;
    }
    [self.timerArry removeObjectForKey:timerName];
    [self.timerActionBlockCacheArry removeObjectForKey:timerName];
    dispatch_source_cancel(timer);
}

#pragma mark - getter & setter
- (NSMutableDictionary *)timerArry {
    if (!_timerArry) {
        _timerArry = [[NSMutableDictionary alloc] init];
    }
    return _timerArry;
}

- (NSMutableDictionary *)timerActionBlockCacheArry {
    if (!_timerActionBlockCacheArry) {
        _timerActionBlockCacheArry = [[NSMutableDictionary alloc] init];
    }
    return _timerActionBlockCacheArry;
}

#pragma mark - private method
- (void)cacheAction:(dispatch_block_t)action forTimer:(NSString *)timerName {
    id actionArray = [self.timerActionBlockCacheArry objectForKey:timerName];
    if (actionArray && [actionArray isKindOfClass:[NSMutableArray class]]) {
        [(NSMutableArray *)actionArray addObject:action];
    } else {
        NSMutableArray *array = [NSMutableArray arrayWithObject:action];
        [self.timerActionBlockCacheArry setObject:array forKey:timerName];
    }
}

- (void)removeActionCacheForTimer:(NSString *)timerName {
    if (![self.timerActionBlockCacheArry objectForKey:timerName]) {
        return;
    }
    [self.timerActionBlockCacheArry removeObjectForKey:timerName];
}

@end
