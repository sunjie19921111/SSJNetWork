//
//  SSJRequestService.m
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import "SSJRequestService.h"
#import "SSJNetWork.h"

@implementation SSJRequestService

- (void)GET:(NSString *)URLString ClassName:(NSString *)className parameters:(id)parameter completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
     [self method:@"GET" ClassName:className urlsString:URLString parameters:parameter completion:completion];
}

- (void)POST:(NSString *)URLString ClassName:(NSString *)className parameters:(id)parameter completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    [self method:@"POST" ClassName:className urlsString:URLString parameters:parameter completion:completion];
}

- (void)method:(NSString *)method ClassName:(NSString *)className urlsString:(NSString *)urlString parameters:(id)parameters completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    SSJNetworkRequestConfig *requestConfig = [[SSJNetworkRequestConfig alloc] init];
    requestConfig.method = method;
    requestConfig.className = className;
    requestConfig.urlString = urlString;
    requestConfig.params = parameters;
    [self networkRequestConfig:requestConfig completion:completion];
}

- (void)networkRequestConfig:(SSJNetworkRequestConfig *)config  completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    [[SSJApiRequestManager requestManager] ssj_networkRequestConfig:config completion:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
        //一些错误提示处理
        if (error.code == SSJApiManagerErrorTypeNoNetWork) {
            //错误提示
        } else if (error.code == SSJApiManagerErrorTypeTimeOut) {
            //错误提示
        }
        if (completion) {
            completion(error,completion);
        }
        
    }];
}

@end
