//
//  RNOLServerHostFactory.m
//  RongNiuOnline
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 rongniu. All rights reserved.
//

#import "RNOLServerHostFactory.h"
#import "RNOLServerHostDev.h"
#import "RNOLServerHostTest.h"
#import "RNOLServerHostNormal.h"

@implementation RNOLServerHostFactory

+ (RNOLBaseServerHost *)createServerHostType:(RNOLServerHostEnvironmentType)type{
    RNOLBaseServerHost *baseServerHost = nil;
    switch (type) {
        case RNOLServerHostEnvironmentTypeNormal:
            baseServerHost = [[RNOLServerHostNormal alloc] init];
            break;
        case RNOLServerHostEnvironmentTypeTest:
            baseServerHost = [[RNOLServerHostTest alloc] init];
            break;
        case RNOLServerHostEnvironmentTypeDev:
            baseServerHost = [[RNOLServerHostDev alloc] init];
            break;
        default:
            baseServerHost = [[RNOLServerHostDev alloc] init];
            break;
    }
    return baseServerHost;
}

@end
