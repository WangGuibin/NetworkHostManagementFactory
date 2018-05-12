//
//  RNOLServerHostManager.h
//  RongNiuOnline
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 rongniu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,RNOLServerHostEnvironmentType) {
    RNOLServerHostEnvironmentTypeNormal = 0,
    RNOLServerHostEnvironmentTypeTest ,
    RNOLServerHostEnvironmentTypeDev ,
    RNOLServerHostEnvironmentTypeUnknow
};

///MARK:- 域名管理类
@interface RNOLServerHostManager : NSObject

//设置默认的配置
+ (void)defaultServerHostConfiguration;
//当前环境的tips
+ (NSString *)currentServerHostEnvironmentName;
//设置接口的域名环境
+ (void)setAPIServerHostType:(RNOLServerHostEnvironmentType)type;
//当前接口的域名环境
+ (RNOLServerHostEnvironmentType)currentAPIServerHostType;
//返回当前接口域名
+ (NSString *)currentServerHost;
//返回当前H5域名
+ (NSString *)currentWebHost;

@end
