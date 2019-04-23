//
//  SSJURLRequestManager.h
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSJNetworkRequestConfig.h"
#import "SSJHTTPSessionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSJNetWorkRequestModel : NSObject

@property (nonatomic, copy)   NSString *requestID;
@property (nonatomic, copy)   NSString *ClassName;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) SSJNetworkRequestConfig *requestConfig;
@property (nonatomic, strong) SSJHTTPSessionModel *sessionModel;

- (instancetype)initWithRequestID:(NSString *)requestID ClassName:(NSString *)className dataTask:(NSURLSessionDataTask *)dataTask RequestConfig:(SSJNetworkRequestConfig *)requestConfig sessionModel:(SSJHTTPSessionModel *)model;

@end

@interface SSJURLRequestManager : NSObject

+ (SSJURLRequestManager *)requestManager;

- (void)ssj_cancelAllRequest;
- (void)ssj_removeObjectRequestID:(NSString *)requestID;
- (void)ssj_cancelObjectRequestID:(NSString *)requestID;
- (void)ssj_cancelObjectClassName:(NSString *)className;
- (void)ssj_addObjectRequestModel:(SSJNetWorkRequestModel *)model;
-(SSJNetWorkRequestModel *)ssj_valueForKeyRequestID:(NSString *)requestID;

@end

NS_ASSUME_NONNULL_END
