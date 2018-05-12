//
//  RNOLNetworkManager.m
//  RongNiuOnline
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 rongniu. All rights reserved.
//

#import "RNOLNetworkManager.h"
#import "AFNetworking.h"


@interface RNOLNetworkManager()

@property (nonatomic,strong) AFHTTPSessionManager *httpManager;

@end


@implementation RNOLNetworkManager

- (AFHTTPSessionManager *)httpManager{
    if (!_httpManager) {
        _httpManager = [AFHTTPSessionManager manager];
        _httpManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/x-json",nil];
        _httpManager.requestSerializer.timeoutInterval = 10; //10s超时
    }
    return _httpManager;
}


+ (instancetype)shareManager{
    static RNOLNetworkManager *_manager = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[RNOLNetworkManager alloc] init];
    });
    return _manager;
}

- (void)GET:(NSString *)url parameters:(NSDictionary *)params complationHandle:(void (^)(id, NSError *))completed{
		[self.httpManager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
			completed(responseObject, nil);
		} failure:^(NSURLSessionTask *operation, NSError *error) {
			completed(nil,error);
		}];
}

- (void)POST:(NSString *)url parameters:(NSDictionary *)params complationHandle:(void (^)(id, NSError *))completed{
		[self.httpManager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
			completed(responseObject, nil);
		} failure:^(NSURLSessionTask *operation, NSError *error) {
			completed(nil,error);
		}];
}

/**  DELETE请求  */
- (void)DELETE: ( NSString * ) url
    parameters: (NSDictionary * ) params
complationHandle: (void (^) ( id responseObject, NSError * error ) ) completed{
    [self.httpManager DELETE: url parameters: params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completed(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completed(nil,error);
    }];
}

/**  PUT请求  */
- (void)PUT: ( NSString * ) url
 parameters: (NSDictionary * ) params
complationHandle: (void (^) ( id responseObject, NSError * error ) ) completed{
    [self.httpManager PUT: url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completed(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completed(nil, error);
    }];
}

/** 上传文件 */
- (void)uploadFileWithURL:(NSString *)url
               parameters: (NSDictionary * )params
                 fileData:(NSData *)fileData
                 progress:(void(^)(NSString * uploadProgress))progressBlock
         complationHandle:(void (^) ( id responseObject, NSError * error ))completeBlock{
    [self.httpManager POST: url parameters: params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传图片文件参数
        [formData appendPartWithFileData: fileData name:@"imageData" fileName:@"fileName" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印上传进度
        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        NSLog(@"%.2lf%%", progress);
        NSString * progressStr = [NSString stringWithFormat:@"%.2lf%%", progress];
        !progressBlock? : progressBlock(progressStr);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        !completeBlock? : completeBlock(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"请求失败：%@",error);
        !completeBlock? : completeBlock(nil,error);
    }];
}

- (void)cancelAllOperations{
	// 停止所有操作
	[self.httpManager.operationQueue cancelAllOperations];
}

/**
 *   监听网络状态的变化
 */
+  (void)checkingNetworkResult:(void (^)(RNOLNetworkStateType networkState ))result {
	AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
	[reachabilityManager startMonitoring];
	[reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
		if (status == AFNetworkReachabilityStatusUnknown) {
			if (result) result(RNOLNetworkStateTypeUnknow);
		}else if (status == AFNetworkReachabilityStatusNotReachable){
			if (result) result(RNOLNetworkStateTypeUnknow);
		}else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
			if (result) result(RNOLNetworkStateType4G);
		}else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
			if (result) result(RNOLNetworkStateTypeWiFi);
		}
	}];
}

@end
