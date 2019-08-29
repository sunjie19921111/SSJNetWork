//
//  NSObject+SJNetWork.h
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

#import <Foundation/Foundation.h>
@class SSJNetworkRequestConfig;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SSJNetWorkImageType) {
    SSJNetWorkImageTypeJPEG,
    SSJNetWorkImageTypePNG,
    SSJNetWorkImageTypeGIF,
    SSJNetWorkImageTypeTIFF,
    SSJNetWorkImageTypeUNKNOWN
};

@interface NSObject (SSJNetWork)

- (void)GET:(NSString *)URLString parameters:(nullable id)parameter completion:(void(^)(NSError *error, id responseObject))completion;

- (void)GET:(NSString *)URLString parameters:(nullable id)parameter useCache:(BOOL)useCache completion:(void(^)(NSError *error, id responseObject))completion;

- (void)HEAD:(NSString *)URLString
                             parameters:(nullable id)parameters
                             completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion;

- (void)POST:(NSString *)URLString parameters:(nullable id)parameter completion:(void(^)(NSError *error, id responseObject))completion;

- (void)POST:(NSString *)URLString parameters:(nullable id)parameter
    useCache:(BOOL)useCache completion:(void(^)(NSError *error, id responseObject))completion;

- (void)POST:(NSString *)URLString parameters:(nullable id)parameter
    useCache:(BOOL)useCache
    progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress completion:(void(^)(NSError *error, id responseObject))completion;

- (void)PUT:(NSString *)URLString parameters:(nullable id)parameter completion:(void(^)(NSError *error, id responseObject))completion;

- (void)DELETE:(NSString *)URLString parameters:(nullable id)parameter completion:(void(^)(NSError *error, id responseObject))completion;
//
- (void)PATCH:(NSString *)URLString parameters:(nullable id)parameter
     progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress completion:(void(^)(NSError *error, id responseObject))completion;

- (NSURLSessionDataTask *)upload:(NSString *)url params:(id)params
                            name:(NSString *)name
                          images:(NSArray<UIImage *> *)images
                      imageScale:(CGFloat)imageScale
                       imageType:(SSJNetWorkImageType)imageType
                        progress:(void (^)(NSProgress * _Nonnull))progress
                      completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion;

- (NSURLSessionDataTask *)upload:(NSString *)url
                          params:(id)params
                            name:(NSString *)name
                      imageDatas:(NSArray<NSData *> *)imageDatas
                        progress:(void (^)(NSProgress * _Nonnull))progress
                      completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion;

- (NSURLSessionDataTask *)upload:(NSString *)url
                          params:(id)params
                            name:(NSString *)name
                        fileName:(NSString *)fileName
                        videoURL:(NSString *)videoURL
                        progress:(void (^)(NSProgress * _Nonnull))progress
                      completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion;

- (NSURLSessionDownloadTask *)download:(NSString *)url
                               fileDir:(NSString *)fileDir
                              progress:(void (^)(NSProgress * _Nonnull))progress
                            completion:(void (^)(NSError * _Nonnull, NSURL *filePath))completion;

@end

NS_ASSUME_NONNULL_END
