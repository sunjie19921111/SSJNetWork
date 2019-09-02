//
//  NSObject+SJNetWork.m
//  SJNetWork
//
//  Created by Sunjie on 2019/4/11.
//  Copyright © 2019 sxmaps. All rights reserved.
//

#import "NSObject+SSJNetWork.h"
#import "SSJNetWork.h"
#import "SSJNetWorkConfig.h"
#import <AFHTTPSessionManager.h>

__attribute__((overloadable)) NSData * UIImageAnimatedGIFRepresentation(UIImage *image, NSTimeInterval duration, NSUInteger loopCount, NSError * __autoreleasing *error) {
    if (!image.images) {
        return nil;
    }
    
    NSDictionary *userInfo = nil;
    {
        size_t frameCount = image.images.count;
        NSTimeInterval frameDuration = (duration <= 0.0 ? image.duration / frameCount : duration / frameCount);
        NSDictionary *frameProperties = @{
                                          (__bridge NSString *)kCGImagePropertyGIFDictionary: @{
                                                  (__bridge NSString *)kCGImagePropertyGIFDelayTime: @(frameDuration)
                                                  }
                                          };
        
        NSMutableData *mutableData = [NSMutableData data];
        CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)mutableData, kUTTypeGIF, frameCount, NULL);
        
        NSDictionary *imageProperties = @{ (__bridge NSString *)kCGImagePropertyGIFDictionary: @{
                                                   (__bridge NSString *)kCGImagePropertyGIFLoopCount: @(loopCount)
                                                   }
                                           };
        CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)imageProperties);
        
        for (size_t idx = 0; idx < image.images.count; idx++) {
            CGImageDestinationAddImage(destination, [[image.images objectAtIndex:idx] CGImage], (__bridge CFDictionaryRef)frameProperties);
        }
        
        BOOL success = CGImageDestinationFinalize(destination);
        CFRelease(destination);
        
        if (!success) {
            userInfo = @{
                         NSLocalizedDescriptionKey: NSLocalizedString(@"Could not finalize image destination", nil)
                         };
            
            goto _error;
        }
        
        return [NSData dataWithData:mutableData];
    }
_error: {
    if (error) {
        *error = [[NSError alloc] initWithDomain:@"com.compuserve.gif.image.error" code:-1 userInfo:userInfo];
    }
    
    return nil;
}
}

@implementation NSObject (SSJNetWork)


- (void)GET:(NSString *)URLString parameters:(id)parameter completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    [self GET:URLString parameters:parameter useCache:YES completion:completion];
}

- (void)GET:(NSString *)URLString parameters:(id)parameter useCache:(BOOL)useCache completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    [self networkRequestUrl:URLString parameters:parameter Method:@"GET" useCache:useCache progress:nil  completion:completion];
}

- (void)HEAD:(NSString *)URLString
                             parameters:(nullable id)parameters
                             completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    [self networkRequestUrl:URLString parameters:parameters Method:@"HEAD" useCache:NO progress:nil completion:completion];
}

- (void)POST:(NSString *)URLString parameters:(id)parameter completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    [self POST:URLString parameters:parameter useCache:YES progress:nil completion:completion];
}

- (void)POST:(NSString *)URLString parameters:(id)parameter useCache:(BOOL)useCache completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    [self POST:URLString parameters:parameter useCache:useCache progress:nil completion:completion];
}

- (void)POST:(NSString *)URLString parameters:(id)parameter useCache:(BOOL)useCache progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress completion:(nonnull void (^)(NSError * _Nonnull, id _Nonnull))completion {
    [self networkRequestUrl:URLString parameters:parameter Method:@"POST" useCache:useCache progress:uploadProgress  completion:completion];
  
}

- (void)DELETE:(NSString *)URLString parameters:(id)parameter completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    [self networkRequestUrl:URLString parameters:parameter Method:@"DELETE" useCache:NO progress:nil completion:completion];
}

- (void)PATCH:(NSString *)URLString parameters:(id)parameter progress:(void (^)(NSProgress * _Nonnull))uploadProgress completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    [self networkRequestUrl:URLString parameters:parameter Method:@"PATCH" useCache:NO progress:uploadProgress completion:completion];
}

- (void)PUT:(NSString *)URLString parameters:(id)parameter completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    [self networkRequestUrl:URLString parameters:parameter Method:@"PUT" useCache:NO progress:nil
        completion:completion];
}

- (void)networkRequestUrl:(NSString *)urlString
               parameters:(id)parameter Method:(NSString *)method
                 useCache:(BOOL)useCache
                 progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    SSJNetworkRequestConfig *config = [[SSJNetworkRequestConfig alloc] init];
    config.method = method;
    config.urlString = urlString;
    config.params = parameter;
    config.useCache = useCache;
    config.className = NSStringFromClass(self.class);
    [self networkRequestConfig:config progress:uploadProgress completion:completion];
}

- (void)networkRequestConfig:(SSJNetworkRequestConfig *)config
                    progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    config.urlString = [self dealWithURL:config.urlString];
    [[SSJApiRequestManager requestManager] ssj_callRequestConfig:config progress:uploadProgress completionBlock:^(NSError * _Nullable error, id  _Nullable responseObject) {
        if (completion) {
            completion(error,responseObject);
        }
    }];

}

- (NSURLSessionDataTask *)upload:(NSString *)url params:(id)params
          name:(NSString *)name
        images:(NSArray<UIImage *> *)images
    imageScale:(CGFloat)imageScale
     imageType:(SSJNetWorkImageType)imageType
      progress:(void (^)(NSProgress * _Nonnull))progress
    completion:(void (^)(NSError * _Nullable, id _Nonnull))completion {
    
    
    NSURLSessionDataTask *dataTask = [[SSJNetWorkConfig netWorkConfig].sessionManager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSUInteger i = 0; i < images.count; i++) {
            NSData *imageData = nil;
            if (imageType == SSJNetWorkImageTypeGIF) {
                imageData = UIImageAnimatedGIFRepresentation(images[i], imageScale, 0, nil);
            }else {
                imageData = UIImageJPEGRepresentation(images[i], imageScale);
            }
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *suffix = @"";
            switch (imageType) {
                case SSJNetWorkImageTypeJPEG:
                    suffix = @"jpeg";
                    break;
                case SSJNetWorkImageTypePNG:
                    suffix = @"png";
                    break;
                case SSJNetWorkImageTypeGIF:
                    suffix = @"gif";
                    break;
                case SSJNetWorkImageTypeTIFF:
                    suffix = @"tiff";
                    break;
                default:
                    suffix = @"png";
                    break;
            }
            NSString *imageFileName = [NSString stringWithFormat:@"%@%@.%@", str, @(i), suffix];
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:imageFileName
                                    mimeType:[NSString stringWithFormat:@"image/%@",suffix]];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progress) {
                progress(uploadProgress);
            }
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        if (completion) {
            completion(responseObject,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(nil,error);
        }
    }];
    return dataTask;
    
}

- (NSURLSessionDataTask *)upload:(NSString *)url
                          params:(id)params
                            name:(NSString *)name
                      imageDatas:(NSArray<NSData *> *)imageDatas
                        progress:(void (^)(NSProgress * _Nonnull))progress
                      completion:(void (^)(NSError * _Nullable, id _Nonnull))completion {
    
    NSURLSessionDataTask *dataTask = [[SSJNetWorkConfig netWorkConfig].sessionManager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSUInteger i = 0; i < imageDatas.count; i++) {
            NSData *imageData = imageDatas[i];
            SSJNetWorkImageType imageType = [self typeForImageData:imageData];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *suffix = @"";
            switch (imageType) {
                case SSJNetWorkImageTypeJPEG:
                    suffix = @"jpeg";
                    break;
                case SSJNetWorkImageTypePNG:
                    suffix = @"png";
                    break;
                case SSJNetWorkImageTypeGIF:
                    suffix = @"gif";
                    break;
                case SSJNetWorkImageTypeTIFF:
                    suffix = @"tiff";
                    break;
                default:
                    suffix = @"png";
                    break;
            }
            NSString *imageFileName = [NSString stringWithFormat:@"%@%@.%@", str, @(i), suffix];
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:imageFileName
                                    mimeType:[NSString stringWithFormat:@"image/%@",suffix]];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progress) {
                progress(uploadProgress);
            }
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        if (completion) {
            completion(responseObject,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            
            completion(nil,error);
        }
    }];

    return dataTask;
    
}

- (SSJNetWorkImageType)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return SSJNetWorkImageTypeJPEG;
        case 0x89:
            return SSJNetWorkImageTypePNG;
        case 0x47:
            return SSJNetWorkImageTypeGIF;
        case 0x49:
        case 0x4D:
            return SSJNetWorkImageTypeTIFF;
    }
    return SSJNetWorkImageTypeUNKNOWN;
}

- (NSURLSessionDataTask *)upload:(NSString *)url
        params:(id)params
          name:(NSString *)name
      fileName:(NSString *)fileName
      videoURL:(NSString *)videoURL
      progress:(void (^)(NSProgress * _Nonnull))progress
    completion:(void (^)(NSError * nullable, id _Nonnull))completion {
    
    NSString *URL = [self dealWithURL:url];
    NSURLSessionDataTask *dataTask = [[SSJNetWorkConfig netWorkConfig].sessionManager POST:URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *extension = [videoURL lastPathComponent];
        NSString *mimeType = [NSString stringWithFormat:@"video/%@", extension];
        if (fileName && fileName.length > 0) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:videoURL] name:name fileName:[NSString stringWithFormat:@"%@.%@", fileName, extension] mimeType:mimeType error:nil];
        }else {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *customName = [NSString stringWithFormat:@"%@.%@", str, extension];
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:videoURL] name:name fileName:customName mimeType:mimeType error:nil];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progress) {
                progress(uploadProgress);
            }
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        if (completion) {
            completion(responseObject,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(nil,error);
        }
    }];

    return dataTask;
}

- (NSURLSessionDownloadTask *)download:(NSString *)url
                               fileDir:(NSString *)fileDir
                              progress:(void (^)(NSProgress * _Nonnull))progress
                            completion:(void (^)(NSError * _Nullable, NSURL *filePath))completion {
    
    
    NSString *URL = [self dealWithURL:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    __block NSURLSessionDownloadTask *downloadTask = [[SSJNetWorkConfig netWorkConfig].sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progress) {
                progress(downloadProgress);
            }
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (completion) {
            completion(error,filePath);
        }
        
    }];
    [downloadTask resume];
    return downloadTask;
}

- (NSString *)dealWithURL:(NSString *)url{
    NSString *urlString = [NSURL URLWithString:url relativeToURL:[NSURL URLWithString:[SSJNetWorkConfig netWorkConfig].baseUrl]].absoluteString;
    return urlString;
}

@end
