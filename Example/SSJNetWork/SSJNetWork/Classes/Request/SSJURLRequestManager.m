//
//  SSJURLRequestManager.m
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

- (void)ssj_addObjectRequestModel:(SSJNetWorkRequestModel *)model {
    @synchronized (self) {
        [_requestIds addObject:model];
    }
}

- (void)ssj_removeObjectRequestID:(NSString *)requestID {
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

-(SSJNetWorkRequestModel *)ssj_valueForKeyRequestID:(NSString *)requestID {
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

- (void)ssj_cancelObjectRequestID:(NSString *)requestID {
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

- (void)ssj_cancelObjectClassName:(NSString *)className {
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

- (void)ssj_cancelAllRequest {
    [self.requestIds removeAllObjects];
}

@end
