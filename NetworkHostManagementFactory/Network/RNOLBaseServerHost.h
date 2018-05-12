//
//  RNOLServerHost.h
//  RongNiuOnline
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 rongniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RNOLServerHostProtocol<NSObject>

- (NSString *)serverClientHost;
- (NSString *)webClientHost;

@end

// 接口类
@interface RNOLBaseServerHost : NSObject<RNOLServerHostProtocol>


@end


