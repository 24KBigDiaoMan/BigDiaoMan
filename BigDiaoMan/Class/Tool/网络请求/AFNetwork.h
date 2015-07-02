//
//  AFNetwork.h
//  XMPP
//
//  Created by xjkj on 14-8-1.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"//数据请求
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "ParametersReceive.h"//参数对接
@interface AFNetwork : NSObject
+ (AFHTTPRequestOperationManager*)shareAFHTTPClient;
//------返回成功统一处理
+(void)getHTTPSuccessful:(AFHTTPRequestOperation*)operation
         stateSuccessful:(void(^)(NSDictionary*successfulDic))successfulblock
            stateFailure:(void(^)(NSDictionary*failureDic))failureblock;
//返回状态失败处理
+(void)dealWtihFailure:(int)state wtihNav:(UIViewController*)vc;
//-----返回失败统一处理
+(void)getHTTPFailure:(NSError *)error
                   stateFailure:(void(^)(NSDictionary*failureDic))failureblock;

+(NSDictionary*)getBackJson:(NSData*)data;
@end
