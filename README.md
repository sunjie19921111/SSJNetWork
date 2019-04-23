
# SJNetwork

对AFNetWorking 二次封装 实现自动取消网络请求，网络请求缓冲，网络请求日志详细打印

## 特性

- 支持缓存写入模式、读取模式、有效时长等自定义配置 (同时享有来着 YYCache 的优越性能)
- 支持按版本号缓存网络请求内容
- 支持按时间缓存网络请求内容
- 半自动取消网络请求
- 支持 Block 回调方式
- 代码层级简单，便于功能拓展
-使用NetworkEye记录网络请求和请求日志
- 支持progressHUD文本自定义


## 安装

第一种方式：
1. 下载 SJNetwork 文件夹所有内容并且拖入你的工程中。


第二种方式：
pod 'SJNetwork'

请pod导入这些依赖库
pod 'MBProgressHUD'
pod 'YYCache'
pod 'FMDB/SQLCipher', '~> 2.5'
pod 'AFNetworking', '~>3.1.0'


## 用法

可下载 DEMO 查看示例。

### 基本使用

#### 1、第一步

请配置SJNetWorkConfig参数

#### 2、第二步 

####第一种封装方式
封装SJApiRequestManager如demo中： NSObject (SJNetWork)

//封装post请求
- (void)POST:(NSString *)URLString parameters:(id)parameter completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
SJNetworkRequestConfig *config = [[SJNetworkRequestConfig alloc] init];
config.method = @"POST";
config.urlString = URLString;
config.params = parameter;
[self networkRequestConfig:config completion:completion];
}

//封装get请求
- (void)GET:(NSString *)URLString parameters:(id)parameter completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
SJNetworkRequestConfig *config = [[SJNetworkRequestConfig alloc] init];
config.method = @"GET";
config.urlString = URLString;
config.params = parameter;
[self networkRequestConfig:config completion:completion];
}

//封装自定义参数请求
- (void)networkRequestConfig:(SJNetworkRequestConfig *)config completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
config.className = NSStringFromClass(self.class);
[[SJApiRequestManager requestManager] sj_networkRequestConfig:config completion:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
//一些错误提示处理
if (error.code == SJApiManagerErrorTypeNoNetWork) {
//错误提示
} else if (error.code == SJApiManagerErrorTypeTimeOut) {
//错误提示
}
if (completion) {
completion(error,completion);
}}];


####第二种封装方式

@implementation SXRequestService

- (void)POST:(NSString *)URLString parameters:(id)parameter className:(NSString *)clsName  completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
[self method:@"POST" ClassName:clsName urlsString:URLString parameters:parameter completion:completion];
}

- (void)GET:(NSString *)URLString parameters:(id)parameter className:(NSString *)clsName completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
[self method:@"GET" ClassName:clsName urlsString:URLString parameters:parameter completion:completion];
}

- (void)method:(NSString *)method ClassName:(NSString *)className urlsString:(NSString *)urlString parameters:(id)parameters completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
SJNetworkRequestConfig *requestConfig = [[SJNetworkRequestConfig alloc] init];
equestConfig.method = method;
requestConfig.className = className;
requestConfig.urlString = urlString;
requestConfig.params = parameters;
[self networkRequestConfig:requestConfig completion:completion];
}

- (void)networkRequestConfig:(SJNetworkRequestConfig *)config  completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
[[SJApiRequestManager requestManager] sj_networkRequestConfig:config completion:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
//一些错误提示处理
if (error.code == SJApiManagerErrorTypeNoNetWork) {
//错误提示
} else if (error.code == SJApiManagerErrorTypeTimeOut) {
//错误提示
}
if (completion) {
completion(error,completion);
}
}];}

@end


第一种的比第二种的优势在于不用传className(类名)，和初始化,具体使用那种，请开发者自行选择


#### 3、第三步
封装每个类对应的serice处理网络各自的网络请求 如demo中：

#define kHomeUrl  @"https://news-at.zhihu.com/api/4/news/9710114"

@interface SJHomeRequestService ()

@property (nonatomic, assign) SJHomeViewController *vc;

@end

@implementation SJHomeRequestService

- (instancetype)initWitHomeVC:(SJHomeViewController *)vc {
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

#### 3、第四步

- (void)viewDidLoad {
[super viewDidLoad];
// Do any additional setup after loading the view.
[self setupConfigurator];
[self loadData];
}

- (void)setupConfigurator {
_requestService = [[SJHomeRequestService alloc] initWitHomeVC:self];
}

- (void)loadData {
/ /回调什么具体可以自己在block里面定义
[_requestService getHomeRequestUserId:@"123" completion:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
NSLog(@"请求数据成功");
}];;
}





### 缓存处理

缓存处理配置都在SJNetWorkConfig和SJNetworkRequestConfig类中，支持以下配置：
- 内存/磁盘存储方式
- 缓存的有效时长
- 根据请求shouldAllIgnoreCache判断是否需要缓存
- 以及直接配置 YYCache
- 支持缓冲最大数量（采用YYCache LRU算法）
- 缓存的版本

### 半自动取消网络请求

请配置  SJNetworkRequestConfigz 中 className 如不传入参数网络请求对应vc的className,则自动取消网络请求无效
半自动取消网络请求根据的的是，视图pop和dismiss的时候取消当前VC下所有的网络请求设计的

### Log日志打印和Log日志Sql记录
`SJNetWorkConfig`变量配置，

dubugLogeEnable：请求完成控制台直接输出
SQLLogEnable:记录在sql提高跳转到vc的时候展示
ne_sqlitePassword：log日志数据库密码
ne_saveRequestMaxCount：保存请求的最大个数


### 网络请求 ProgressHUD 的显示和文本的设置

SJNetworkRequestConfig 配置参数

showProgressHUD:是否显示
progressHUDText：请求的时候ProgressHUD显示的文本



参考源码：[YTKNetwork](https://github.com/yuantiku/YTKNetwork) [CTNetworking](https://github.com/casatwy/CTNetworking)
