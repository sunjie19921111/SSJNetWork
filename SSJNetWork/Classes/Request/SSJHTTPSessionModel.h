//
//  SSJHTTPSessionModel.h
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSJHTTPSessionModel : NSObject

@property (nonatomic, strong) NSURLRequest          *ne_request;
@property (nonatomic, strong) NSHTTPURLResponse     *ne_response;
@property (nonatomic, assign) double                ID;
@property (nonatomic, strong) NSString              *startDateString;
@property (nonatomic, strong) NSString              *endDateString;

//request
@property (nonatomic, strong) NSString              *requestURLString;
@property (nonatomic, strong) NSString              *requestCachePolicy;
@property (nonatomic, assign) double                requestTimeoutInterval;
@property (nonatomic, nullable, strong) NSString    *requestHTTPMethod;
@property (nonatomic, nullable,strong)  NSString    *requestAllHTTPHeaderFields;
@property (nonatomic, nullable,strong)  NSString    *requestHTTPBody;

//response
@property (nonatomic, nullable, strong) NSString    *responseMIMEType;
@property (nonatomic, strong) NSString              *responseExpectedContentLength;
@property (nonatomic, nullable, strong) NSString    *responseTextEncodingName;
@property (nullable, nonatomic, strong) NSString    *responseSuggestedFilename;
@property (nonatomic, assign) NSInteger             responseStatusCode;
@property (nonatomic, nullable, strong) NSString    *responseAllHeaderFields;

//JSONData
@property (nonatomic, strong) NSString              *receiveJSONData;

@property (nonatomic, strong) NSString              *mapPath;
@property (nonatomic, strong) NSString              *mapJSONData;


@property (nonatomic, strong) NSString              *errorDescription;

- (void)startLoadingRequest:(NSURLRequest *)request;
- (void)endLoadingResponse:(NSURLResponse *)response responseObject:(id)responseObject ErrorDescription:(NSString *)errorDescription;


@end

NS_ASSUME_NONNULL_END
