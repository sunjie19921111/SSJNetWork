//
//  SSJNetworkRequestConfig.m
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import "SSJNetworkRequestConfig.h"

@implementation SSJNetworkRequestConfig

- (instancetype)init {
    if (self = [super init]) {
        _shouldAllIgnoreCache = NO;
        _params = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return self;
}

@end
