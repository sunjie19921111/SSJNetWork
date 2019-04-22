//
//  SSJNetWorkHelper.h
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSJNetWorkHelper : NSObject

/**
 Get current time
 
 @return current time
 */
+ (NSDate *)ssj_currentDate;

/**
 Get app version
 
 @return The app version
 */
+ (NSString *)ssj_appVersion;

/**
 Get current time
 
 @return The current time
 */
+ (NSString *)ssj_currentTimeString;

/**
 Set the format
 
 @return Time format
 */
+ (NSDateFormatter *)ssj_dateFormatter;

/**
 Compare the current time to the anotherDate size
 
 @param anotherDate time
 @return YES currentDay > anotherDay NO currentDay > anotherDay
 */
+ (BOOL)ssj_ratherCurrentTimeWithAnotherTime:(NSDate *)anotherDate;


/**
 Comparison time size
 
 @param oneDay time
 @param anotherDay time
 @return YES oneDay > anotherDay NO oneDay > anotherDay
 */
+ (BOOL)ssj_ratherCurrentTimeDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

/**
 Whether the network is connected
 
 @return YES connection  NO not  connection
 */
+ (BOOL)ssj_isReachable;


@end

NS_ASSUME_NONNULL_END
