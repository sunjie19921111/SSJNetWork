//
//  UINavigationController+SSJNetWork.m
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import "UINavigationController+SSJNetWork.h"
#import "SSJNetworkingDefines.h"
#import "SSJURLRequestManager.h"

@implementation UINavigationController (SSJNetWork)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzling_exchangeMethod([self class],@selector(popViewControllerAnimated:), @selector(ssj_popViewControllerAnimated:));
        swizzling_exchangeMethod([self class],@selector(popToRootViewControllerAnimated:), @selector(ssj_popToRootViewControllerAnimated:));
        swizzling_exchangeMethod([self class],@selector(popToViewController:animated:), @selector(ssj_popToViewController:animated:));
    });
}

- (nullable UIViewController *)ssj_popViewControllerAnimated:(BOOL)animated; {
    [self canceledClassRequest];
    return [self ssj_popViewControllerAnimated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)ssj_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self canceledClassRequest];
    
    return [self ssj_popToViewController:viewController animated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)ssj_popToRootViewControllerAnimated:(BOOL)animated {
    [self canceledClassRequest];
    return [self ssj_popToRootViewControllerAnimated:animated];
}

- (void)canceledClassRequest{
    [[SSJURLRequestManager requestManager] ssj_cancelObjectClassName:NSStringFromClass([self.topViewController class])];
}

@end
