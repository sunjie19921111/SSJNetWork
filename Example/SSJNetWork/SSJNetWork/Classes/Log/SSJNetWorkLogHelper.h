//
//  SSJNetWorkLogHelper.h
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSJHTTPSessionModel;

NS_ASSUME_NONNULL_BEGIN

@interface SSJNetWorkLogHelper : NSObject

- (instancetype)initWithSessionModel:(SSJHTTPSessionModel *)sessionModel;

- (NSString *)printRequestLog;

@end

NS_ASSUME_NONNULL_END
