//
//  YAProxy.h
//  YASideMenu
//
//  Created by Qiqiuzhe on 2020/5/10.
//  Copyright © 2020 app-01 org. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YAProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)obj;

@end

NS_ASSUME_NONNULL_END
