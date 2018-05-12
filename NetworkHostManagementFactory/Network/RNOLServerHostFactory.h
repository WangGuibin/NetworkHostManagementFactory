//
//  RNOLServerHostFactory.h
//  RongNiuOnline
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 rongniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNOLBaseServerHost.h"

///域名简单工厂
@interface RNOLServerHostFactory : NSObject

+ (RNOLBaseServerHost *)createServerHostType:(RNOLServerHostEnvironmentType)type;

@end
