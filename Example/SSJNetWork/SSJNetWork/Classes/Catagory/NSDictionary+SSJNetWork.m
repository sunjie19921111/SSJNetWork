//
//  NSDictionary+SSJNetWork.m
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/22.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import "NSDictionary+SSJNetWork.h"

@implementation NSDictionary (SSJNetWork)

- (NSString *)ssj_transformToUrlParamString {
    NSMutableString *paramString = [NSMutableString string];
    for (int i = 0; i < self.count; i ++) {
        NSString *string = nil;
        if (i == 0) {
            string = [NSString stringWithFormat:@"?%@=%@",self.allKeys[i],self[self.allKeys[i]]];
        } else {
            string = [NSString stringWithFormat:@"&%@=%@",self.allKeys[i],self[self.allKeys[i]]];
        }
        [paramString appendString:string];
    }
    return paramString;
}

- (NSString *)ssj_jsonString {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



@end
