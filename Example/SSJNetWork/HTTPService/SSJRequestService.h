//
//  SSJRequestService.h
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSJRequestService : NSObject

- (void)GET:(NSString *)URLString ClassName:(NSString *)className parameters:(nullable id)parameter completion:(void(^)(NSError *error, id responseObject))completion;


- (void)POST:(NSString *)URLString ClassName:(NSString *)className parameters:(nullable id)parameter
  completion:(void(^)(NSError *error, id responseObject))completion;

@end

NS_ASSUME_NONNULL_END
