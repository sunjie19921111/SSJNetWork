//
//  SJHomeRequestService.m
//  SJNetWork
//
//  Created by Sunjie on 2019/4/17.
//  Copyright © 2019 sxmaps. All rights reserved.
//

#import "SSJHomeRequestService.h"
#import "NSObject+SSJNetWork.h"
#import "SSJHomeViewController.h"

//NSString *url2 = @"https://news-at.zhihu.com/api/4/news/9710114";
//NSString *url3 = @"https://news-at.zhihu.com/api/4/news/9710124";
//NSString *url4 = @"https://news-at.zhihu.com/api/4/news/9710133";
//NSString *url5 = @"https://news-at.zhihu.com/api/4/news/9710027";;


#define kHomeUrl  @"https://news-at.zhihu.com/api/4/news/9710114"

@interface SSJHomeRequestService ()

@property (nonatomic, assign) SSJHomeViewController *vc;

@end

@implementation SSJHomeRequestService

- (instancetype)initWitHomeVC:(SSJHomeViewController *)vc {
    if (self = [super init]) {
        self.vc = vc;
    }
    return self;
}

- (void)getHomeRequestUserId:(NSString *)userId completion:(nonnull void (^)(NSError * _Nonnull, id _Nonnull))completion{
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
//    [params setObject:userId forKey:@"userId"]
    
    [self.vc GET:kHomeUrl parameters:nil completion:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
        //转化成对应的模型回调
        if (completion) {
            completion(error,responseObject);
        }
        
    }];
}

@end
