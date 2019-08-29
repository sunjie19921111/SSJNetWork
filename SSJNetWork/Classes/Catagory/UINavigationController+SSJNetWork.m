//
//  UINavigationController+SSJNetWork.m
//  SSJNetWork_Example
//
//  Copyright (c) 2012-2016 SSJNetWork https://github.com/sunjie19921111/SSJNetWork
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
