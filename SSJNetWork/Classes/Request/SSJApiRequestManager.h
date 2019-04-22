//
//  SSJApiRequestManager.h
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SSJNetworkRequestConfig;

NS_ASSUME_NONNULL_BEGIN

@interface SSJApiRequestManager : NSObject

+ (instancetype)requestManager;

- (void)ssj_networkRequestConfig:(SSJNetworkRequestConfig *)config completion:(void(^)(NSError *error, id responseObject))completion;

@end

NS_ASSUME_NONNULL_END
