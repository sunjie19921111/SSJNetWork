//
//  SSJNetWorkConfig.h
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFJSONResponseSerializer;
@class AFHTTPSessionManager;

NS_ASSUME_NONNULL_BEGIN

@interface SSJNetWorkConfig : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)netWorkConfig;

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

@property (readwrite,nonatomic, strong) AFJSONResponseSerializer *responseSerializer;
@property (readwrite,nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (readwrite,nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;

@end

NS_ASSUME_NONNULL_END
