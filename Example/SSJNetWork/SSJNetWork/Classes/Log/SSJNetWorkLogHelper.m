//
//  SSJNetWorkLogHelper.m
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import "SSJNetWorkLogHelper.h"
#import <UIKit/UIKit.h>
#import "SSJHTTPSessionModel.h"

@interface SSJNetWorkLogHelper ()

@property (nonatomic, strong) SSJHTTPSessionModel *model;

@end

@implementation SSJNetWorkLogHelper


- (instancetype)initWithSessionModel:(SSJHTTPSessionModel *)sessionModel {
    if (self = [super init]) {
        self.model = sessionModel;
    }
    return self;
}

- (NSString *)printRequestLog {
    NSMutableString *logString = [[NSMutableString alloc] init];
    
    NSString *requestStart = [NSString stringWithFormat:@"\n---------------------requestStart----------------------\n"];
    NSString *startDateString = [NSString stringWithFormat:@" [startDate] : %@",self.model.startDateString];
    NSString *endDateString = [NSString stringWithFormat:@"\n [endDate] : %@",self.model.endDateString];;
    NSString *requestURLString = [NSString stringWithFormat:@"[requestURL] : %@\n",self.model.requestURLString];
    NSString *requestCachePolicyString = [NSString stringWithFormat:@"[requestCachePolicy] : %@\n",self.model.requestCachePolicy];
    NSString *requestTimeoutInterval = [NSString stringWithFormat:@"[requestTimeoutInterval] : %f",self.model.requestTimeoutInterval];
    NSString *requestHTTPMethod = [NSString stringWithFormat:@"[requestHTTPMethod] : %@ ",self.model.requestHTTPMethod];
    NSString *requestAllHTTPHeaderFields = [NSString stringWithFormat:@"[requestAllHTTPHeaderFields] : %@\n", self.model.requestAllHTTPHeaderFields];
    NSString *requestHTTPBody = [NSString stringWithFormat:@"[requestHTTPBody]  : %@ \n", self.model.requestHTTPBody];
    NSString *responseMIMEType = [NSString stringWithFormat:@"[requestAllHTTPHeaderFields] : %@ \n", self.model.responseMIMEType];
    NSString *responseExpectedContentLength = [NSString stringWithFormat:@"[responseExpectedContentLength] : %@",self
                                               .model.responseExpectedContentLength];
    NSString *responseTextEncodingName = [NSString stringWithFormat:@"[responseTextEncodingName]: : %@",self.model.responseTextEncodingName];
    NSString *responseSuggestedFilename = [NSString stringWithFormat:@"[responseSuggestedFilename]: : %@",self.model.responseSuggestedFilename];
    NSString *responseStatusCode = [NSString stringWithFormat:@"[responseStatusCode]: : %ld",(long)self.model.responseStatusCode];
    NSString *responseAllHeaderFields = [NSString stringWithFormat:@"[responseAllHeaderFields] : %@\n",self.model.responseAllHeaderFields];
    NSString *errorDescription = nil;
    NSString *receiveJSONData = nil;
    if (!self.model.errorDescription) {
        errorDescription = [NSString stringWithFormat:@"[responseJSON] : %@",self.model.errorDescription];
    } else {
        receiveJSONData = [NSString stringWithFormat:@"[responseJSON] : %@",self.model.receiveJSONData];
    }
    NSString *requestEnd = [NSString stringWithFormat:@"\n---------------------requestEnd----------------------\n"];
    
    [logString appendString:requestStart];
    [logString appendString:startDateString];
    [logString appendString:endDateString];
    [logString appendString:requestURLString];
    [logString appendString:requestCachePolicyString];
    [logString appendString:requestTimeoutInterval];
    [logString appendString:requestHTTPMethod];
    [logString appendString:requestAllHTTPHeaderFields];
    [logString appendString:requestHTTPBody];
    [logString appendString:responseMIMEType];
    [logString appendString:responseExpectedContentLength];
    [logString appendString:responseTextEncodingName];
    [logString appendString:responseSuggestedFilename];
    [logString appendString:responseStatusCode];
    [logString appendString:responseAllHeaderFields];
    if (!errorDescription) {
        [logString appendString:receiveJSONData];
    } else {
        [logString appendString:errorDescription];
    }
    [logString appendString:requestEnd];
    
    return logString.copy;
}

@end
