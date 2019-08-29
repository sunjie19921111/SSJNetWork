//
//  SSJNetWorkConfig.h
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

#import <Foundation/Foundation.h>

@class AFJSONResponseSerializer;
@class AFHTTPSessionManager;

NS_ASSUME_NONNULL_BEGIN

@interface SSJNetWorkConfig : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)netWorkConfig;


@property (readwrite,nonatomic, strong) NSString *baseUrl;

/**
 Set the maximum cache limit
 */
@property (readwrite,nonatomic, assign) NSInteger countLimit;

/**
 Network timeout
 */
@property (readwrite,nonatomic, assign) NSInteger timeoutInterval;

/**
 Cache version
 */
@property (readwrite,nonatomic, assign) NSString *memoryCacheVersion;

/**
 Cache expiration time
 */
@property (readwrite,nonatomic, assign) NSString *cacheTimeInSeconds;

/**
 Request header
 */
@property (readwrite, nonatomic, strong) NSMutableDictionary *mutableHTTPRequestHeaders;


/**
 Whether log printing is enabled
 */
@property (readwrite,nonatomic, assign) BOOL dubugLogeEnable;

/**
 Whether SQLLog is enabled
 */
@property (readwrite,nonatomic, assign) BOOL SQLLogEnable;

/**
 log password
 */
@property (readwrite,nonatomic, assign) NSString *ne_sqlitePassword;
/**
 Set the maximum cache limit
 */
@property (readwrite,nonatomic, assign) NSInteger ne_saveRequestMaxCount;

/**
 demo  [SJNetWorkConfig netWorkConfig].sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
 */

@property (readwrite,nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

NS_ASSUME_NONNULL_END
