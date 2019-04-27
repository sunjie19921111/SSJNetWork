//
//  SJNetworkingDefines.h
//  SJNetWork
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

#ifndef SSJNetworkingDefines_h
#define SSJNetworkingDefines_h
#import <objc/runtime.h>
#import "SSJNetWorkConfig.h"

static inline void swizzling_exchangeMethod(Class _Nonnull clazz, SEL _Nonnull originalSelector, SEL _Nonnull swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(clazz, swizzledSelector);
    
    BOOL success = class_addMethod(clazz, originalSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    if (success) {
        class_replaceMethod(clazz, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

typedef NS_ENUM(NSInteger,SSJApiManagerErrorType) {
    SSJApiManagerErrorTypeRefreshToken = -1,
    SSJApiManagerErrorTypeLogin = -2,
    SSJApiManagerErrorTypeCanceled = -3,
    SSJApiManagerErrorTypeNoNetWork = -4,
    SSJApiManagerErrorTypeTimeOut = -5,
    SSJApiManagerErrorTypeSuccess = -6,
    SSJApiManagerErrorTypeCacheExpire = -7,
    SSJApiManagerErrorTypeDateExpire = -8,
    SSJApiManagerErrorTypeAppVersionExpire = -9,
    SSJApiManagerErrorTypeInvaliData = -10,
};

typedef NS_ENUM(NSInteger,SSJApiManagerNetWorkType) {
    SSJApiManagerNetWorkTypeWiFi = 1,
    SSJApiManagerNetWorkTypeWWAN ,
    SSJApiManagerNetWorkTypeNoReachable,
};

NSString * const AFNetworkingReachabilityDidChangeNotification = @"com.networking.reachability.change";
NSString * const AFNetworkingReachabilityNotificationStatusItem = @"AFNetworkingReachabilityNotificationStatusItem";


#endif /* SJNetworkingDefines_h */
