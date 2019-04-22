//
//  UIViewController+SSJNetWork.m
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import "UIViewController+SSJNetWork.h"
#import "SSJNetworkingDefines.h"
#import "SSJURLRequestManager.h"

@implementation UIViewController (SSJNetWork)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzling_exchangeMethod([self class],@selector(dismissViewControllerAnimated:completion:), @selector(ssj_dismissViewControllerAnimated:completion:));
    });
}

- (void)ssj_dismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion {
    [self ssj_dismissViewControllerAnimated:flag completion:completion];
    [self canceledClassRequest];
}

- (void)canceledClassRequest {
    [[SSJURLRequestManager requestManager] sj_cancelObjectClassName:NSStringFromClass([self class])];
}


@end
