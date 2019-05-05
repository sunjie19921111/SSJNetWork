//
//  SJMemCacheDataCenter.h
//  SJNetWork
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

#import <Foundation/Foundation.h>

typedef void(^SJJCacheQueryCompletedBlock)(id response, NSError *error);

@interface SSJMemCacheConfigModel : NSObject<NSSecureCoding>

@property (nonatomic, copy)   NSString *cacheVersion;
@property (nonatomic, copy)   NSDate   *cacheTime;
@property (nonatomic, copy)   NSString *appVersion;
- (instancetype)initWithCacheTime:(NSDate*)cacheTime;

@end


@interface SSJMemCacheDataCenter : NSObject

+ (instancetype)shareInstance;

- (void)sj_configSetObject:(id<NSCoding>)object forKey:(NSString *)key;
- (id)sj_configObjectForKey:(NSString *)key;
- (void)sj_configRemoveObjectForKey:(NSString *)key;
- (void)sj_configRemoveAllObjects;

- (void)sj_responseSetObject:(id<NSCoding>)object forKey:(NSString *)key;
- (id)sj_responseObjectForKey:(NSString *)key;
- (void)sj_responseRemoveObjectForKey:(NSString *)key;
- (void)sj_responseRemoveAllObjects;

- (void)sj_responseAndConfigRemoveAllObjects;

@end
