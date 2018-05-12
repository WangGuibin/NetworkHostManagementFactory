//
//  RNOLServerHostManager.m
//  RongNiuOnline
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 rongniu. All rights reserved.
//

#import "RNOLServerHostManager.h"
#import "RNOLServerHostFactory.h"


#define kUserDefaults [NSUserDefaults standardUserDefaults]

static NSString * const kAPIServerHostKey = @"kAPIServerHostKey";

@implementation RNOLServerHostManager

//设置默认的配置
+ (void)defaultServerHostConfiguration{
    RNOLServerHostEnvironmentType type =  [RNOLServerHostManager currentAPIServerHostType];
    if (type == RNOLServerHostEnvironmentTypeUnknow) {
        [RNOLServerHostManager setAPIServerHostType: RNOLServerHostEnvironmentTypeNormal]; //设置默认的环境
    }else{
        [RNOLServerHostManager setAPIServerHostType: type];
    }
}

//设置接口的域名环境
+ (void)setAPIServerHostType:(RNOLServerHostEnvironmentType)type{
    [kUserDefaults setObject:@(type).stringValue forKey:kAPIServerHostKey];
    [kUserDefaults synchronize];
}

//当前接口的域名环境
+ (RNOLServerHostEnvironmentType)currentAPIServerHostType{
    NSString *typeStr = [kUserDefaults objectForKey: kAPIServerHostKey];
    if (!typeStr || !typeStr.length) {
        typeStr = @(RNOLServerHostEnvironmentTypeUnknow).stringValue;//默认是没有的
    }
    RNOLServerHostEnvironmentType type = [typeStr integerValue];
    return type;
}

//返回当前接口域名
+ (NSString *)currentServerHost{
    RNOLServerHostEnvironmentType type = [[kUserDefaults objectForKey: kAPIServerHostKey] integerValue];
    RNOLBaseServerHost * serverHost = [RNOLServerHostFactory createServerHostType: type];
    return serverHost.serverClientHost;
}

//返回当前H5域名
+ (NSString *)currentWebHost{
    RNOLServerHostEnvironmentType type = [[kUserDefaults objectForKey: kAPIServerHostKey] integerValue];
    RNOLBaseServerHost * serverHost = [RNOLServerHostFactory createServerHostType: type];
    return serverHost.webClientHost;
}

//tips
+ (NSString *)currentServerHostEnvironmentName{
    RNOLServerHostEnvironmentType type = [[kUserDefaults objectForKey: kAPIServerHostKey] integerValue];
    NSString *serverName = nil;
    switch (type) {
        case RNOLServerHostEnvironmentTypeNormal:
            serverName = @"线上环境";
            break;
        case RNOLServerHostEnvironmentTypeTest:
            serverName = @"测试环境";
            break;
        case RNOLServerHostEnvironmentTypeDev:
            serverName = @"Dev环境";
            break;
        default:
            break;
    }
    return serverName;
}




@end
