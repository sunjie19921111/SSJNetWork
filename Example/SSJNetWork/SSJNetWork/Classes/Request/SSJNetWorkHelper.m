//
//  SSJNetWorkHelper.m
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import "SSJNetWorkHelper.h"
#import "NSDictionary+SSJNetWork.h"
#import "NSString+SSJNetWork.h"
#import "SSJNetWorkConfig.h"


#if __has_include(<AFNetworking/AFNetworkReachabilityManager.h>)
#import <AFNetworking/AFNetworkReachabilityManager.h>
#else
#import "AFNetworkReachabilityManager.h"
#endif


@implementation SSJNetWorkHelper

+ (NSDate *)ssj_currentDate {
    return [NSDate date];
}

+ (NSString *)ssj_appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (BOOL)ssj_ratherCurrentTimeDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay {
    NSTimeInterval delta  = [oneDay timeIntervalSinceDate:anotherDay];
    CGFloat minutes = [[SSJNetWorkConfig netWorkConfig].cacheTimeInSeconds floatValue];
    if (delta > 60 * minutes) {
        return NO;
    }
    return YES;
}

+ (BOOL)ssj_ratherCurrentTimeWithAnotherTime:(NSDate *)anotherDate {
    NSDate *now = [self ssj_currentDate];
    return [self ssj_ratherCurrentTimeDay:now withAnotherDay:anotherDate];
}

+ (NSString *)ssj_currentTimeString {
    return [[self ssj_dateFormatter] stringFromDate:[self ssj_currentDate]];
}

+ (NSDateFormatter *)ssj_dateFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-mm-dd hh:mm:ss zzz"];
    });
    return formatter;
}

+ (BOOL)ssj_isReachable {
    __block BOOL reachable = YES;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager  sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
            reachable = NO;
        }
    }];
    return reachable;
}



@end
