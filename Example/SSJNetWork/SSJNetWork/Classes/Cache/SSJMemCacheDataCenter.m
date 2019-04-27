//
//  SJMemCacheDataCenter.m
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

#import "SSJMemCacheDataCenter.h"
#import "SSJNetWorkConfig.h"
#import "SSJNetWorkHelper.h"

#if __has_include(<YYCache/YYCache.h>)
#import <YYCache/YYCache.h>
#else
#import "YYCache.h"
#endif

@interface SSJMemCacheConfigModel ()

@end

@implementation SSJMemCacheConfigModel

- (instancetype)initWithCacheTime:(NSDate *)cacheTime {
    if (self = [super init]) {
        self.cacheTime = cacheTime;
        self.cacheVersion = [SSJNetWorkConfig netWorkConfig].memoryCacheVersion;
        self.appVersion = [SSJNetWorkHelper ssj_appVersion];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.cacheVersion forKey:NSStringFromSelector(@selector(cacheVersion))];
    [coder encodeObject:self.cacheTime forKey:NSStringFromSelector(@selector(cacheTime))];
    [coder encodeObject:self.appVersion forKey:NSStringFromSelector(@selector(appVersion))];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.appVersion = [aDecoder decodeObjectOfClass:[NSString class] forKey:NSStringFromSelector(@selector(appVersion))];
        self.cacheTime = [aDecoder decodeObjectOfClass:[NSString class] forKey:NSStringFromSelector(@selector(cacheTime))];
        self.cacheVersion = [aDecoder decodeObjectOfClass:[NSString class] forKey:NSStringFromSelector(@selector(cacheVersion))];
    }
    return self;
}

@end

@interface SSJMemCacheDataCenter ()

@property (nonatomic, strong) YYCache *configMemoryCache;
@property (nonatomic, strong) YYCache *responseMemoryCache;
@property (nonatomic, strong) YYCache *requestcMemoryCache;

@end

@implementation SSJMemCacheDataCenter

+ (instancetype)shareInstance {
    static SSJMemCacheDataCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[SSJMemCacheDataCenter alloc] init];
    });
    return center;
}

- (instancetype)init {
    if (self  = [super init]) {

        _responseMemoryCache = [[YYCache alloc] initWithName:NSStringFromClass([self class])];
        _responseMemoryCache.memoryCache.countLimit = [SSJNetWorkConfig netWorkConfig].countLimit;
        _responseMemoryCache.diskCache.countLimit = [SSJNetWorkConfig netWorkConfig].countLimit;;
        _configMemoryCache = [[YYCache alloc] initWithName: NSStringFromClass([SSJMemCacheConfigModel class])];
        _configMemoryCache.memoryCache.countLimit = [SSJNetWorkConfig netWorkConfig].countLimit;
        _configMemoryCache.diskCache.countLimit = [SSJNetWorkConfig netWorkConfig].countLimit;;
        
    }
    return self;
}

- (void)sj_configSetObject:(id<NSCoding>)object forKey:(NSString *)key {
    [_configMemoryCache setObject:object forKey:key];
}
- (id<NSCoding>)sj_configObjectForKey:(NSString *)key {
   return [_configMemoryCache objectForKey:key];
}
- (void)sj_configRemoveObjectForKey:(NSString *)key {
    [_configMemoryCache removeObjectForKey:key];
}
- (void)sj_configRemoveAllObjects {
    [_configMemoryCache removeAllObjects];
}

- (void)sj_responseSetObject:(id<NSCoding>)object forKey:(NSString *)key {
    [_responseMemoryCache setObject:object forKey:key];
}
- (id)sj_responseObjectForKey:(NSString *)key {
    return [_responseMemoryCache objectForKey:key];
}
- (void)sj_responseRemoveObjectForKey:(NSString *)key {
    [_responseMemoryCache removeObjectForKey:key];
}
- (void)sj_responseRemoveAllObjects {
    [_responseMemoryCache removeAllObjects];
}

- (void)sj_responseAndConfigRemoveAllObjects {
    [_configMemoryCache removeAllObjects];
    [_responseMemoryCache removeAllObjects];
}

@end
