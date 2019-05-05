//
//  SJHomeViewController.m
//  SJNetWork
//
//  Created by Sunjie on 2019/4/17.
//  Copyright © 2019 sxmaps. All rights reserved.
//

#import "SSJHomeViewController.h"
#import "SSJHomeRequestService.h"
#import "SSJNetWork.h"

@interface SSJHomeViewController ()

@property (nonatomic, strong) SSJHomeRequestService *requestService;

@end

@implementation SSJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupConfigurator];
    [self loadData];
}

- (void)setupConfigurator {
    _requestService = [[SSJHomeRequestService alloc] initWitHomeVC:self];
}

- (void)loadData {
    //回调什么具体可以自己在block里面定义
    [_requestService getHomeRequestUserId:@"123" completion:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
        NSLog(@"请求数据成功");
    }];;
    [_requestService getHomeRequestUserName:@"" completion:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
        NSLog(@"请求数据成功");
    }];
}

- (IBAction)clickLogButton:(id)sender {
    UIViewController *vc = [SSJLogManager sharedManager].LogViewController;
    [self presentViewController:vc animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
