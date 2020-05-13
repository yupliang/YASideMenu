//
//  QueueThreadPool.m
//  SilkyWXList
//
//  Created by app-01 on 2020/5/13.
//  Copyright © 2020 Doogore. All rights reserved.
//

#import "QueueThreadPool.h"

@implementation QueueThreadPool
+ (QueueThreadPool *)sharedInstance {
    static QueueThreadPool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QueueThreadPool alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _backQueue = dispatch_queue_create("QueueThreadPool.backqueue", NULL);
    }
    return self;
}
@end
