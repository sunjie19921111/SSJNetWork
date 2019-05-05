//
//  SSJNetWorkConfig.m
//  SSJNetWork_Example
//
//  Copyright (c) 2012-2016 SSJNetWork https://github.com/sunjie19921111/SSJNetWork
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
