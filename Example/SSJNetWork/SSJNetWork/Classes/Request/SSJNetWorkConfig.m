//
//  SSJNetWorkConfig.m
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import "SSJNetWorkConfig.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

@implementation SSJNetWorkConfig

+ (instancetype)netWorkConfig{
    static SSJNetWorkConfig *netWorkConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkConfig = [[self alloc] init];
    });
    
    return netWorkConfig;
}

- (instancetype)init {
    if (self = [super init]) {
        
        _timeoutInterval = 30;
        _cacheTimeInSeconds = @"3";
        _memoryCacheVersion = @"1";
        _countLimit = 5;
        _mutableHTTPRequestHeaders = [NSMutableDictionary dictionaryWithCapacity:1];
        _ne_sqlitePassword = @"SJNetwork";
        _ne_saveRequestMaxCount = 300;
        _SQLLogEnable = YES;
        _dubugLogeEnable = YES;
        
        _sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:self.sessionConfiguration];
    }
    return self;
}

@end
