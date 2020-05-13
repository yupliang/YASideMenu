//
//  QueueThreadPool.h
//  SilkyWXList
//
//  Created by app-01 on 2020/5/13.
//  Copyright © 2020 Doogore. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QueueThreadPool : NSObject

@property (nonatomic,strong,class,readonly) QueueThreadPool *sharedInstance;
- (instancetype)init NS_UNAVAILABLE;
@property (nonatomic,strong,readonly) dispatch_queue_t backQueue;
@end

NS_ASSUME_NONNULL_END
