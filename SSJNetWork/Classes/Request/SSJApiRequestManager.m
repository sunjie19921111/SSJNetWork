//
//  SSJApiRequestManager.m
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import "SSJApiRequestManager.h"
#import "SSJNetWorkConfig.h"
#import "SSJApiProxy.h"
#import "SSJNetworkingDefines.h"
#import "NSString+SSJNetWork.h"
#import "SSJMemCacheDataCenter.h"
#import "SSJNetWorkHelper.h"
#import "NSDictionary+SSJNetWork.h"
#import "SSJHTTPSessionModel.h"
#import "SSJURLRequestManager.h"
#import "SSJNetworkRequestConfig.h"

NSString * const SSJRequestCacheErrorDomain = @"com.sxnetwork.request.caching";
NSString * const SSJNetworknFailingDataErrorKey = @"com.network.error.data";

static NSError * SSJErrorWithUnderlyingError(NSError *error, NSError *underlyingError) {
    if (!error) {
        return underlyingError;
    }
    
    if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
        return error;
    }
    
    NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
    mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
    
    return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}

@interface SSJApiRequestManager ()

@property (nonatomic, assign) SSJApiManagerErrorType errorType;
@property (nonatomic, strong) NSString *cachePath;
@property (nonatomic, strong) SSJURLRequestManager *requestManager;
@property (nonatomic, strong) SSJNetWorkConfig *netWorkConfig;
@property (nonatomic, strong) SSJNetworkRequestConfig *requestConfig;

@end

@implementation SSJApiRequestManager

+ (instancetype)requestManager {
    static SSJApiRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SSJApiRequestManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _requestManager = [SSJURLRequestManager requestManager];
        _netWorkConfig = [SSJNetWorkConfig netWorkConfig];
    }
    return self;
}


- (void)ssj_networkRequestConfig:(SSJNetworkRequestConfig *)config completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    self.requestConfig = config;
    NSError *validationError = nil;
    id json = nil;
    if (![SSJNetWorkHelper ssj_isReachable]) {
        NSMutableDictionary *mutableUserInfo = [@{
                                                  NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Request failed: not network"],
                                                  } mutableCopy];
        validationError = SSJErrorWithUnderlyingError([NSError errorWithDomain:SSJRequestCacheErrorDomain code:SSJApiManagerErrorTypeNoNetWork userInfo:mutableUserInfo], validationError);
        completion(validationError,json);
        return;
    }
    
    validationError = [self loadMemoryCacheData];
    if (!validationError) {
        json = [self getResponseObjectData];
    }
    
    if (json) {
        completion(validationError,json); return;
    }
    
    [[SSJApiProxy sharedInstance] callNetWorkRequestConfig:config completion:^(NSError * _Nonnull error, id  _Nonnull responseObject, SSJNetworkRequestConfig * _Nonnull requestConfig) {
        self.requestConfig  = requestConfig;
        if (completion) {
            completion(error,responseObject);
        }
        if (!error) {
            [self saveCacheConfig];
            [self saveResponseObject:responseObject];
        }
    }];
}
- (void)saveCacheConfig {
    SSJMemCacheConfigModel *config = [[SSJMemCacheConfigModel alloc] initWithCacheTime:[NSDate date]];
    [[SSJMemCacheDataCenter shareInstance] sj_configSetObject:config forKey:self.cachePath];
}

- (NSError *)loadMemoryCacheData {
    NSString *key = self.cachePath;
    SSJMemCacheConfigModel *model = [[SSJMemCacheDataCenter shareInstance] sj_configObjectForKey:key];
    NSError *validationError = nil;
    
    if (!model) {
        NSMutableDictionary *mutableUserInfo = [@{
                                                  NSLocalizedDescriptionKey: [NSString stringWithFormat:@"failed: not cache data"],
                                                  } mutableCopy];
        validationError = SSJErrorWithUnderlyingError([NSError errorWithDomain:SSJRequestCacheErrorDomain code:SSJApiManagerErrorTypeInvaliData userInfo:mutableUserInfo], validationError);
        return validationError;
    }
    BOOL isExpire = [SSJNetWorkHelper ssj_ratherCurrentTimeWithAnotherTime:model.cacheTime];
    if (!isExpire) {
        NSMutableDictionary *mutableUserInfo = [@{
                                                  NSLocalizedDescriptionKey: [NSString stringWithFormat:@"failed: cache data date expire"],
                                                  } mutableCopy];
        validationError = SSJErrorWithUnderlyingError([NSError errorWithDomain:SSJRequestCacheErrorDomain code:SSJApiManagerErrorTypeCacheExpire userInfo:mutableUserInfo], validationError);
        return validationError;
    }
    NSString *appVersion = [SSJNetWorkHelper ssj_appVersion];
    NSString *currentAppVersion = model.appVersion;
    if (appVersion.length != currentAppVersion.length || ![appVersion isEqualToString: currentAppVersion]) {
        NSMutableDictionary *mutableUserInfo = [@{
                                                  NSLocalizedDescriptionKey: [NSString stringWithFormat:@"failed: cache data version expire"],
                                                  } mutableCopy];
        validationError = SSJErrorWithUnderlyingError([NSError errorWithDomain:SSJRequestCacheErrorDomain code:SSJApiManagerErrorTypeAppVersionExpire userInfo:mutableUserInfo], validationError);
        return validationError;
    }
    
    if (validationError) {
        [[SSJMemCacheDataCenter shareInstance] sj_responseRemoveObjectForKey:key];
        [[SSJMemCacheDataCenter shareInstance] sj_configRemoveObjectForKey:key];
    }
    
    return validationError;
}

- (void)saveResponseObject:(id)object {
    
    //判断缓冲时间和是否忽略缓冲
    if ([_netWorkConfig.cacheTimeInSeconds integerValue] <= 0 || self.requestConfig.shouldAllIgnoreCache) {
        return;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    if (!data || data.length < 1) {
        return;
    }
    NSString *key = self.cachePath;
    [[SSJMemCacheDataCenter shareInstance] sj_responseSetObject:data forKey:key];
}

- (id)getResponseObjectData {
    NSError *validationError = nil;
    if ([_netWorkConfig.cacheTimeInSeconds integerValue] <= 0 || self.requestConfig.shouldAllIgnoreCache) {
        NSMutableDictionary *mutableUserInfo = [@{
                                                  NSLocalizedDescriptionKey: [NSString stringWithFormat:@"failed: cacheTimeInSeconds and IgnoreCache"],
                                                  } mutableCopy];
        validationError = SSJErrorWithUnderlyingError([NSError errorWithDomain:SSJRequestCacheErrorDomain code:SSJApiManagerErrorTypeCacheExpire userInfo:mutableUserInfo], validationError);
        return nil;
    }
    NSString *key = self.cachePath;
    NSData *data = [[SSJMemCacheDataCenter shareInstance] sj_responseObjectForKey:key];
    if (!data || data.length < 1) {
        NSMutableDictionary *mutableUserInfo = [@{
                                                  NSLocalizedDescriptionKey: [NSString stringWithFormat:@"failed: invaliData"],
                                                  } mutableCopy];
        validationError = SSJErrorWithUnderlyingError([NSError errorWithDomain:SSJRequestCacheErrorDomain code:SSJApiManagerErrorTypeInvaliData userInfo:mutableUserInfo], validationError);
        return nil;
    }
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (!error) {
        return json;
    }
    return nil;
}

- (NSString *)cachePath {
    NSString *requestString = [NSString stringWithFormat:@"method:%@ url:%@ params:%@",_requestConfig.method,_requestConfig.urlString,_requestConfig.params];
    return [requestString ssj_MD5String];
}

@end
