//
//  SSJNetWorkHelper.m
//  SSJNetWork_Example
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
    
    
    BOOL reachable = YES;
    NSString *netWorkState = [[AFNetworkReachabilityManager sharedManager] localizedNetworkReachabilityStatusString];
    if ([netWorkState isEqualToString:@"Unknow"] || [netWorkState isEqualToString:@"Not Reachable"]) {// 未知 或 无网络
        return reachable = NO;
    }  else if ([netWorkState isEqualToString:@"Reachable via WWAN"]) {// 蜂窝数据
        
    } else {
        
    }
    return reachable;
}



@end
