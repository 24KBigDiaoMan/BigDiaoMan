//
//  Methods.m
//  BigDiaoMan
//
//  Created by xjkj on 14-8-12.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import "Methods.h"
#import "UIAlertView+Fast.h"//系统弹出框快捷方式1
#import "UIActionSheet+Fast.h"//系统弹出框快捷方式2
@implementation Methods
#pragma -mark- ------------------------实用快速方法------------------------
#pragma -mark 延迟几秒执行
+ (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}



#pragma -mark- ------------------------地图经纬度------------------------
#pragma -mark计算经纬度之间的距离
+(double)distanceBetweenOrderByLatitude1:(double)latitude1
                          withLongitude1:(double)longitude1
                            andLatitude2:(double)latitude2
                          withLongitude2:(double)longitude2
{
    CLLocation* curLocation = [[CLLocation alloc]initWithLatitude:latitude1
                                                        longitude:longitude1];
    CLLocation* otherLocation = [[CLLocation alloc]initWithLatitude:latitude2
                                                          longitude:longitude2];
    double distance  = [curLocation distanceFromLocation:otherLocation];
    return distance;
}
#pragma -mark- -------------------------登陆判断常用-------------------------
#pragma -mark md5加密
+(NSString *)md5Digest:(NSString *)digestStr
{
   

    const char *cStr = [digestStr UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}
#pragma -mark 判断邮箱
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma -mark 判断手机号码
+(BOOL)CheckPhoneNumInput:(NSString *)phone
{
    NSString *Regex =@"(13[0-9]|14[57]|15[012356789]|18[02356789])\\d{8}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:phone];
}
#pragma -mark- -------------------------系统-------------------------
#pragma -mark 获得系统当前时间
+(NSString*)getNowTime{
    //                //获得系统日期
    //                NSCalendar  * cal=[NSCalendar  currentCalendar];
    //                NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    //                NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    //                NSInteger year=[conponent year];
    //                NSInteger month=[conponent month];
    //                NSInteger day=[conponent day];
    //                NSString *  nsDateString= [NSString  stringWithFormat:@"%4d年%2d月%2d日",year,month,day];
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    
    return morelocationString;
}
#pragma -mark 获得程序信息
+(NSString *)programInformation:(NSString*)str{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //CLog(@"%@",(infoDictionary));
    //  app名称CFBundleDisplayName
    //  app版本CFBundleShortVersionString
    //  app build版本 CFBundleVersion
    NSString *appStr = [infoDictionary objectForKey:str];
    return appStr;
}
#pragma -mark- ------------------------提示框------------------------
#pragma -mark 提示框1
+(void)alertViewWithTitle:(NSString*)title
              contentText:(NSString*)contStr
          leftButtonTitle:(NSString*)leftstr//nil--0
         rightButtonTitle:(NSString*)rightstr//@"sure"--1
                   finish:(void (^)(NSInteger index))block
{
    
    
        UIAlertView *alert;
        
        alert = [[UIAlertView alloc]initWithTitle:title message:contStr delegate:nil cancelButtonTitle:leftstr otherButtonTitles:rightstr, nil];
        
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (block) {
                block(buttonIndex);
            }
        }];
        
    
}
#pragma -mark 提示框2
+(void)sheetWithTitle:(NSString*)title
              oneText:(NSString*)oneText
              twoText:(NSString*)twoText
               finish:(void (^)(NSInteger index))block{
    UIActionSheet *sheet;
    sheet=[[UIActionSheet alloc]initWithTitle:title
                                     delegate:nil
                            cancelButtonTitle:@"取消"
                       destructiveButtonTitle:nil
                            otherButtonTitles:oneText,twoText, nil];
    //    sheet.actionSheetStyle=UIBarStyleBlack;
    
    [sheet showActionSheetWithCompleteBlock:^(NSInteger buttonIndex) {
        
        if (block) {
            block(buttonIndex);
        }
    }];
}
#pragma -mark ------------------------快速图片拉伸------------------------
+(UIImage*)imageName:(NSString*)name
       WithCapInsets:(UIEdgeInsets)capInsets
        resizingMode:(UIImageResizingMode)resizingMode{
    
    UIImage *image=[[UIImage imageNamed:name]
                    resizableImageWithCapInsets:capInsets
                    resizingMode:resizingMode];
    
    return image;
}
#pragma -mark 快速图片拉伸（0,0,0,0）平铺
+(UIImage*)stretchImageName:(NSString*)name{
    UIImage *image=[[UIImage imageNamed:name]
                    resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)
                    resizingMode:UIImageResizingModeStretch];
    return image;
}
@end
