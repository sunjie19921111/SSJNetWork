//
//  SSJApiProxy.m
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
@property (strong, nonatomic, nullable) dispatch_queue_t iQueue;

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
        _iQueue = dispatch_queue_create("com.network.logQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)callNetWorkRequestConfig:(SSJNetworkRequestConfig *)requestConfig completionBlock:(SJJRequestCompletionBlock)completion {
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

    __block NSURLSessionDataTask *dataTask =  [manager dataTaskWithRequest:mutableRequest
                                                         completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                             [self addCompletionCallback:completion response:response responseObject:responseObject error:error];

                                                         }];



    [dataTask resume];
    
    [self startLoadRequest:mutableRequest dataTask:dataTask RequestConfig:requestConfig];
}

- (void)addCompletionCallback:(SJJRequestCompletionBlock)completedBlock
                    response:(nullable NSURLResponse *)response responseObject:(id  _Nullable)responseObject error:(NSError * _Nullable)error {
    NSString *requestID = response.URL.absoluteString;
    SSJNetWorkRequestModel *requestModel = [self.requestManager ssj_valueForKeyRequestID:requestID];
    [self printRequestLogForRequestID:requestID response:response responseObject:responseObject response:error];
    [self.requestManager ssj_removeObjectRequestID:requestID];
    if (completedBlock) {
        completedBlock(error,responseObject,requestModel.requestConfig);
    }
    
}

- (void)startLoadRequest:(NSMutableURLRequest *)request dataTask:(nonnull NSURLSessionDataTask *)dataTask RequestConfig:(nonnull SSJNetworkRequestConfig *)requestConfig {
    SSJHTTPSessionModel *sessionModel = [[SSJHTTPSessionModel alloc] init];
    NSString *requestID = request.URL.absoluteString;
    SSJNetWorkRequestModel *model = [[SSJNetWorkRequestModel alloc] initWithRequestID:requestID ClassName:requestConfig.className dataTask:dataTask RequestConfig:requestConfig sessionModel:sessionModel];;
    [self.requestManager ssj_addObjectRequestModel:model];
    dispatch_async(self.iQueue, ^{
        [sessionModel startLoadingRequest:request];
    });
}

- (void)printRequestLogForRequestID:(NSString *)requestID response:(nullable NSURLResponse *)response responseObject:(id  _Nullable)responseObject response:(NSError * _Nullable)error {
    SSJNetWorkRequestModel *requestModel = [self.requestManager ssj_valueForKeyRequestID:requestID];
    NSString *errorDescription = error.userInfo[@"NSLocalizedDescription"];
    dispatch_async(self.iQueue , ^{
        [requestModel.sessionModel endLoadingResponse:response responseObject:responseObject ErrorDescription:errorDescription];
    });
}

- (NSDictionary *)HTTPRequestHeaders {
    NSMutableDictionary *mutableHTTPRequestHeaders = [SSJNetWorkConfig netWorkConfig].mutableHTTPRequestHeaders;
    return [NSDictionary dictionaryWithDictionary:mutableHTTPRequestHeaders];
}


@end
