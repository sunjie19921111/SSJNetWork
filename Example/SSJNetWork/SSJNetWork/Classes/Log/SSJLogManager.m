//
//  SSJLogManager.m
//  SSJNetWork_Example
//
//  Created by Sunjie on 2019/4/23.
//  Copyright © 2019 15220092519@163.com. All rights reserved.
//

#import "SSJLogManager.h"
#import "NEHTTPEyeViewController.h"

@implementation SSJLogManager

+ (instancetype)sharedManager {
    static SSJLogManager *logManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logManager = [[SSJLogManager alloc] init];
    });
    return logManager;
}


- (UIViewController *)LogViewController {
    NEHTTPEyeViewController *vc = [[NEHTTPEyeViewController alloc] init];
    return vc;
}

@end
