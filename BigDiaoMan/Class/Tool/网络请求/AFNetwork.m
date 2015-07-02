//
//  AFNetwork.m
//  XMPP
//
//  Created by xjkj on 14-8-1.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import "AFNetwork.h"
//#import "LoginViewController.h"
static NSString *const RootPath = @"http://182.92.216.240:8080";
@implementation AFNetwork
#pragma mark- ------------全局请求单例------------
#pragma mark 初始化
+ (AFHTTPRequestOperationManager*)shareAFHTTPClient{
    static AFHTTPRequestOperationManager *_shareAFHTTPClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        _shareAFHTTPClient = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:RootPath]];
        _shareAFHTTPClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _shareAFHTTPClient.responseSerializer = [AFJSONResponseSerializer serializer];
        [_shareAFHTTPClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [_shareAFHTTPClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    });
    return _shareAFHTTPClient;
}
#pragma mark 网络状态监听
-(void)networkStatusMonitoring{
    AFHTTPRequestOperationManager *manager = [AFNetwork shareAFHTTPClient];
    
    //网络变化
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
         //CLog(@"网络状态改变为:%ld",status);
    }];
    [manager.reachabilityManager startMonitoring];
}
#pragma mark 解析JSONO
+(NSDictionary*)getBackJson:(NSData*)data{
    
    NSError *error;
    
    NSDictionary *resultDic =[NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableLeaves
                                                               error:&error];
    if (error) {
        CLog(@"解析JSONO错误－返回格式不对");
        return nil;
        
    }else{
        CLog(@"请求成功\n%@", resultDic );
      return resultDic;
    }
    
}
#pragma mark- ------------http返回处理------------
#pragma mark ---------返回成功统一处理
+(void)getHTTPSuccessful:(AFHTTPRequestOperation*)operation
         stateSuccessful:(void(^)(NSDictionary*successfulDic))successfulblock
            stateFailure:(void(^)(NSDictionary*failureDic))failureblock{
    
     NSDictionary *resultDic =[AFNetwork getBackJson:operation.responseData];
    //如果解析正常 判断返回状态吗是否正常
    if (resultDic) {
        //
        if ([[resultDic objectForKey:@"state"]intValue]==10000) {
            
            if (successfulblock) {
                successfulblock(resultDic);
            }
            
        }else{
            NSString *desc=[resultDic objectForKey:@"desc"];
            if (!desc) {
                   desc=@"返回状态码错误";
            }
            
            [Methods alertViewWithTitle:@"提示"
                                    contentText:desc
                        leftButtonTitle:nil
                       rightButtonTitle:@"确定"
                                 finish:^(NSInteger index) {
                                     if (failureblock) {
                                         failureblock(resultDic);
                                     }
                                 }];

            
        }
        
        
    }else{
        [Methods alertViewWithTitle:@"提示"
                                   contentText:@"JSONO解析失败"
                               leftButtonTitle:nil
                            rightButtonTitle:@"确定"
                                            finish:^(NSInteger index) {
                                                if (failureblock) {
                                                    failureblock(nil);
                                                }
                                         
                                            }];
    }
    
}
#pragma mark 返回状态失败处理
+(void)dealWtihFailure:(int)state wtihNav:(UIViewController*)vc{
    switch (state) {
        case 10025://用户未登录
        {
//            LoginViewController *login=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:login];
//            login.loginSuccessful=^(void){
//            };
//            [nav presentViewController:nav animated:YES completion:nil];
            
        }
            break;
            
        default:
            break;
    }
}
#pragma mark ---------返回失败统一处理
+(void)getHTTPFailure:(NSError *)error
         stateFailure:(void(^)(NSDictionary*failureDic))failureblock{
    
    if (error) {
         CLog(@"POST请求Error: %@", error);
        //如果不是请求取消[[error userInfo]objectForKey:@"NSLocalizedDescription"]
        if (error.code!=NSURLErrorCancelled) {
            [Methods alertViewWithTitle:@"提示"
                                      contentText:@"请求失败"
                                 leftButtonTitle:nil
                               rightButtonTitle:@"确定"
                                 finish:^(NSInteger index) {
                                     if (failureblock) {
                                         failureblock(nil);
                                     }
                                 }];
        }
        
    }
    
    
}
/*
 
 //------------系统get Post------------------------
 //------------------------------------------------
 
 
 
 //其中缓存协议是个枚举类型包含：
 //NSURLRequestUseProtocolCachePolicy（基础策略）
 
 //NSURLRequestReloadIgnoringLocalCacheData（忽略本地缓存）
 
 //NSURLRequestReturnCacheDataElseLoad（首先使用缓存，如果没有本地缓存，才从原地址下载）
 
 //NSURLRequestReturnCacheDataDontLoad（使用本地缓存，从不下载，如果本地没有缓存，则请求失败，此策略多用于离线操作）
 
 //NSURLRequestReloadIgnoringLocalAndRemoteCacheData（无视任何缓存策略，无论是本地的还是远程的，总是从原地址重新下载）
 
 //NSURLRequestReloadRevalidatingCacheData（如果本地缓存是有效的则不下载，其他任何情况都从原地址重新下载）
 

//同步GET请求
-(void)a{
    
    
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:@"http://api.hudong.com/iphonexml.do?type=focus-c"];
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    
}
//同步POST请求
-(void)b{
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:@"http://api.hudong.com/iphonexml.do"];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = @"type=focus-c";//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    
}
//异步GET请求
-(void)c{
    //第一步，创建url
    NSURL *url = [NSURL URLWithString:@"http://api.hudong.com/iphonexml.do?type=focus-c"];
    //第二步，创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //第三步，连接服务器
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
}
//异步POST请求
-(void)d{
    //第一步，创建url
    NSURL *url = [NSURL URLWithString:@"http://api.hudong.com/iphonexml.do"];
    //第二步，创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *str = @"type=focus-c";
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    //第三步，连接服务器
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
    
    
}
//异步请求的代理方法
//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    
    NSLog(@"%@",[res allHeaderFields]);
    
    //self.receiveData = [NSMutableData data];
    
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // [self.receiveData appendData:data];
    
}

//数据传完之后调用此方法

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@",receiveStr);
    
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    NSLog(@"%@",[error localizedDescription]);
}

 */
@end
