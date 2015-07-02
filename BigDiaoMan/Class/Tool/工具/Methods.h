//
//  Methods.h
//  BigDiaoMan
//
//  Created by xjkj on 14-8-12.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CoreLocation/CoreLocation.h>//经纬度
#import <CommonCrypto/CommonDigest.h>//md5加密
@interface Methods : NSObject


//****************实用快速方法*********************
//延迟几秒执行的方法
+ (void)performBlock:(void(^)())block
          afterDelay:(NSTimeInterval)delay;
//**********************************************




//****************地图经纬度*********************
//计算经纬度之间的距离
+(double)distanceBetweenOrderByLatitude1:(double)latitude1
                          withLongitude1:(double)longitude1
                            andLatitude2:(double)latitude2
                          withLongitude2:(double)longitude2;
//**********************************************




//****************登陆判断常用*********************
//md5加密
+(NSString *)md5Digest:(NSString *)digestStr;
//判断邮箱
+(BOOL)isValidateEmail:(NSString *)email;
//判断手机号码
+(BOOL)CheckPhoneNumInput:(NSString *)phone;
//**********************************************





//****************系统*********************
//获取系统时间
+(NSString*)getNowTime;
//系统版本
+(NSString *)programInformation:(NSString*)str;

//**********************************************







//*********************提示框*********************
//弹出提示框1
+(void)alertViewWithTitle:(NSString*)title
              contentText:(NSString*)contStr
          leftButtonTitle:(NSString*)leftstr
         rightButtonTitle:(NSString*)rightstr
                   finish:(void (^)(NSInteger index))block;

//弹出提示框2
+(void)sheetWithTitle:(NSString*)title
              oneText:(NSString*)oneText
              twoText:(NSString*)twoText
               finish:(void (^)(NSInteger index))block;
//**********************************************




//*********************图片*********************
//快速图片拉伸
+(UIImage*)imageName:(NSString*)name
       WithCapInsets:(UIEdgeInsets)capInsets
        resizingMode:(UIImageResizingMode)resizingMode;
//快速图片拉伸（0,0,0,0）平铺
+(UIImage*)stretchImageName:(NSString*)name;
//**********************************************


@end
