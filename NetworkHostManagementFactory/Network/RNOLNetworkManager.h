//
//  RNOLNetworkManager.h
//  RongNiuOnline
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 rongniu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,RNOLNetworkStateType) {
	RNOLNetworkStateTypeWiFi ,
	RNOLNetworkStateType4G ,
	RNOLNetworkStateTypeUnknow,
};

@interface RNOLNetworkManager : NSObject

+ (instancetype)shareManager ;

/**  GET请求  */
- (void)GET: (NSString *) url
 parameters: ( NSDictionary * ) params
complationHandle: (void (^) (id responseObject, NSError *error) ) completed;

/**  POST请求  */
- (void)POST: ( NSString * ) url
  parameters: (NSDictionary * ) params
complationHandle: (void (^) ( id responseObject, NSError * error ) ) completed;

/**  DELETE请求  */
- (void)DELETE: ( NSString * ) url
    parameters: (NSDictionary * ) params
complationHandle: (void (^) ( id responseObject, NSError * error ) ) completed;

/**  PUT请求  */
- (void)PUT: ( NSString * ) url
 parameters: (NSDictionary * ) params
complationHandle: (void (^) ( id responseObject, NSError * error ) ) completed;


/** 上传文件 */
- (void)uploadFileWithURL:(NSString *)url
               parameters: (NSDictionary * )params
                 fileData:(NSData *)fileData
                 progress:(void(^)(NSString * uploadProgress))progressBlock
         complationHandle:(void (^) ( id responseObject, NSError * error ))completeBlock;


- (void)cancelAllOperations ;

/**
 *   监听网络状态的变化
 */
+  (void)checkingNetworkResult:(void (^)(RNOLNetworkStateType networkState ))result ;

@end
