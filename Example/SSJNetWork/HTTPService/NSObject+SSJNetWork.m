//
//  NSObject+SJNetWork.m
//  SJNetWork
//
//  Created by Sunjie on 2019/4/11.
//  Copyright © 2019 sxmaps. All rights reserved.
//

#import "NSObject+SSJNetWork.h"
#import "SSJNetWork.h"

@implementation NSObject (SSJNetWork)


- (void)POST:(NSString *)URLString parameters:(id)parameter completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    SSJNetworkRequestConfig *config = [[SSJNetworkRequestConfig alloc] init];
    config.method = @"POST";
    config.urlString = URLString;
    config.params = parameter;
    [self networkRequestConfig:config completion:completion];
}

- (void)GET:(NSString *)URLString parameters:(id)parameter completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    SSJNetworkRequestConfig *config = [[SSJNetworkRequestConfig alloc] init];
    config.method = @"GET";
    config.urlString = URLString;
    config.params = parameter;
    [self networkRequestConfig:config completion:completion];
}

- (void)networkRequestConfig:(SSJNetworkRequestConfig *)config completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    config.className = NSStringFromClass(self.class);
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
