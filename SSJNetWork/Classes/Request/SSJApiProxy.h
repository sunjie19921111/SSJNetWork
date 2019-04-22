//
//  SSJApiProxy.h
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSJNetworkRequestConfig;

NS_ASSUME_NONNULL_BEGIN

@interface SSJApiProxy : NSObject

+ (instancetype)sharedInstance;
- (void)callNetWorkRequestConfig:(SSJNetworkRequestConfig *)requestConfig completion:(void(^)(NSError *error, id responseObject,SSJNetworkRequestConfig *requestModel))completion;


@end

NS_ASSUME_NONNULL_END
