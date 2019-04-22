//
//  SSJNetworkRequestConfig.h
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSJNetworkRequestConfig : NSObject

/**
 request metdod
 */
@property (nonatomic, copy) NSString *method;

/**
 requested url
 */
@property (nonatomic, copy) NSString *urlString;

/**
 Request parameters
 */
@property (nonatomic, strong) NSMutableDictionary *params;

/**
 Request the VC class name
 */
@property (nonatomic, copy) NSString *className;

/**
 Ignore Cache
 */
@property (nonatomic, assign) BOOL shouldAllIgnoreCache;


@end

NS_ASSUME_NONNULL_END
