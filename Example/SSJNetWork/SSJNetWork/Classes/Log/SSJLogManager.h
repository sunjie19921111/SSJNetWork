//
//  SSJLogManager.h
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/23.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSJLogManager : NSObject


+ (instancetype)sharedManager;

- (void)start;

- (UIViewController *)demoLogViewController;

@end

NS_ASSUME_NONNULL_END
