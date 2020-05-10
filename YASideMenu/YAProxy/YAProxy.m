//
//  YAProxy.m
//  YASideMenu
//
//  Created by Qiqiuzhe on 2020/5/10.
//  Copyright © 2020 app-01 org. All rights reserved.
//

#import "YAProxy.h"

@interface YAProxy () {
    __weak id target;
}

@end

@implementation YAProxy

+ (instancetype)proxyWithTarget:(id)obj {
    YAProxy *proxy = [YAProxy alloc];
    proxy->target = obj;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self->target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self->target];
}

@end
