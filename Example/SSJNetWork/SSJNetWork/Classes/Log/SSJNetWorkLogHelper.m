//
//  SSJNetWorkLogHelper.m
//  SSJNetWork_Example
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
