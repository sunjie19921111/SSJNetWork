//
//  SSJURLRequestManager.m
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import "SSJURLRequestManager.h"

#import "SSJNetworkRequestConfig.h"
#import "SSJHTTPSessionModel.h"

@implementation SSJNetWorkRequestModel

- (instancetype)initWithRequestID:(NSString *)requestID ClassName:(NSString *)className dataTask:(nonnull NSURLSessionDataTask *)dataTask RequestConfig:(nonnull SSJNetworkRequestConfig *)requestConfig  sessionModel:(nonnull SSJHTTPSessionModel *)model {
    if (self = [ super init]) {
        self.requestID = requestID;
        self.ClassName = className;
        self.dataTask = dataTask;
        self.requestConfig = requestConfig;
        self.sessionModel = model;
    }
    return self;
}

@end

@interface SSJURLRequestManager ()

@property (nonatomic, strong) NSMutableArray *requestIds;

@end

@implementation SSJURLRequestManager

+ (SSJURLRequestManager *)requestManager {
    static SSJURLRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SSJURLRequestManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _requestIds = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void)sj_addObjectRequestModel:(SSJNetWorkRequestModel *)model {
    @synchronized (self) {
        [_requestIds addObject:model];
    }
}

- (void)sj_removeObjectRequestID:(NSString *)requestID {
    @synchronized (self) {
        __block SSJNetWorkRequestModel *model = nil;
        [_requestIds enumerateObjectsUsingBlock:^(SSJNetWorkRequestModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.requestID isEqualToString:requestID]) {
                model = obj;
                *stop = YES;
            }
        }];
        if (model) {
            [self.requestIds removeObject:model];
        }
    }
}

-(SSJNetWorkRequestModel *)sj_valueForKeyRequestID:(NSString *)requestID {
    @synchronized (self) {
        __block SSJNetWorkRequestModel *model = nil;
        [_requestIds enumerateObjectsUsingBlock:^(SSJNetWorkRequestModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.requestID isEqualToString:requestID]) {
                model = obj;
            }
        }];
        return model;
    }
}

- (void)sj_cancelObjectRequestID:(NSString *)requestID {
    @synchronized (self) {
        __block SSJNetWorkRequestModel *model = nil;
        [_requestIds enumerateObjectsUsingBlock:^(SSJNetWorkRequestModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.requestID isEqualToString:requestID]) {
                *stop = YES;
                model = obj;
            }
        }];
        if (model) {
            [model.dataTask cancel];
            [self.requestIds removeObject:model];
        }
    }
}

- (void)sj_cancelObjectClassName:(NSString *)className {
    @synchronized (self) {
        NSMutableArray *classRequests = [NSMutableArray arrayWithCapacity:1];
        [_requestIds enumerateObjectsUsingBlock:^(SSJNetWorkRequestModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.ClassName isEqualToString:className]) {
                [obj.dataTask cancel];
                [classRequests addObject:obj];
            }
        }];
        [classRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.requestIds removeObject:obj];
        }];
    }
}

- (void)sj_cancelAllRequest {
    [self.requestIds removeAllObjects];
}

@end
