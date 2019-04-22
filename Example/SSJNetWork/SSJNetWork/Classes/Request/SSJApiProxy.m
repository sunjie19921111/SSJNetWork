//
//  SSJApiProxy.m
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import "SSJApiProxy.h"
#import "SSJNetWorkConfig.h"
#import "SSJHTTPSessionModel.h"
#import "SSJURLRequestManager.h"
#import "SSJNetworkRequestConfig.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

@interface SSJApiProxy ()

@property (nonatomic, strong) SSJURLRequestManager *requestManager;

@end

@implementation SSJApiProxy

+ (instancetype)sharedInstance {
    static SSJApiProxy *apiProxy = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiProxy = [[[self class] alloc] init];
    });
    return apiProxy;
}

- (instancetype)init {
    if (self = [super init]) {
        _requestManager = [SSJURLRequestManager requestManager];
    }
    return self;
}

- (void)callNetWorkRequestConfig:(SSJNetworkRequestConfig *)requestConfig completion:(nonnull void (^)(NSError * _Nonnull, id _Nonnull, SSJNetworkRequestConfig * _Nonnull))completion {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSDictionary *params = requestConfig.params;
    NSString *method = requestConfig.method;
    NSString *urlString = requestConfig.urlString;
    NSMutableURLRequest *mutableRequest = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:urlString parameters:params error:nil];
    mutableRequest.timeoutInterval = [SSJNetWorkConfig netWorkConfig].timeoutInterval;
    
    [self.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        if (![mutableRequest valueForHTTPHeaderField:field]) {
            [mutableRequest setValue:value forHTTPHeaderField:field];
        }
    }];
    
    
    SSJHTTPSessionModel *sessionModel = [[SSJHTTPSessionModel alloc] init];
    [sessionModel startLoadingRequest:mutableRequest];
    __block NSURLSessionDataTask *dataTask =  [manager dataTaskWithRequest:mutableRequest
                                                         completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                             NSString *requestID = dataTask.currentRequest.URL.absoluteString;
                                                             SSJNetWorkRequestModel *requestModel = [self.requestManager sj_valueForKeyRequestID:requestID];
                                                             NSString *errorDescription = error.userInfo[@"NSLocalizedDescription"];
                                                             [requestModel.sessionModel endLoadingResponse:response responseObject:responseObject ErrorDescription:errorDescription];
                                                             [self.requestManager sj_removeObjectRequestID:requestID];
                                          
                                                             if (completion) {
                                                                 completion(error,responseObject,requestModel.requestConfig);
                                                             }
                                                             
                                                         }];
    [dataTask resume];
    
    NSString *requestID = dataTask.currentRequest.URL.absoluteString;
    SSJNetWorkRequestModel *model = [[SSJNetWorkRequestModel alloc] initWithRequestID:requestID ClassName:requestConfig.className dataTask:dataTask RequestConfig:requestConfig sessionModel:sessionModel];;
    [self.requestManager sj_addObjectRequestModel:model];
}


- (NSDictionary *)HTTPRequestHeaders {
    NSMutableDictionary *mutableHTTPRequestHeaders = [SSJNetWorkConfig netWorkConfig].mutableHTTPRequestHeaders;
    return [NSDictionary dictionaryWithDictionary:mutableHTTPRequestHeaders];
}


@end
