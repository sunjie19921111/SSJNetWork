//
//  SJHomeRequestService.h
//  SJNetWork
//
//  Created by Sunjie on 2019/4/17.
//  Copyright © 2019 sxmaps. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SSJHomeViewController;

NS_ASSUME_NONNULL_BEGIN

@interface SSJHomeRequestService : NSObject

- (instancetype)initWitHomeVC:(SSJHomeViewController *)vc;

//假如有一些参数传递
- (void)getHomeRequestUserId:(NSString *)userId completion:(void(^)(NSError *error, id responseObject))completion;
- (void)getHomeRequestUserName:(NSString *)userName completion:(nonnull void (^)(NSError *error, id responseObject))completion;

@end

NS_ASSUME_NONNULL_END
