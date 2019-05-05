//
//  SSJNetWorkHelper.h
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
