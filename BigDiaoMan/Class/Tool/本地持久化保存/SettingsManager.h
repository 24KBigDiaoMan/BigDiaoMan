//
//  SettingsManager.h
//  APP
//
//  Created by zmx on 14-1-13.
//  Copyright (c) 2014年 zmx. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface SettingsManager : NSObject
+ (SettingsManager *)shardSettingsManager;
@property (nonatomic) BOOL isFirstRun;//第一次开启配置
@property (nonatomic) BOOL isRemberPassWord;//是否记住密码
@property (nonatomic) BOOL isFirstEnter;//判断是否是第一次进入程序
@property (nonatomic) BOOL isLogInEnter;//用户是否登录
@property (nonatomic,copy) NSString *systemVersion;//系统版本


@property (nonatomic,copy) NSString *userType; //用户类型
@property (nonatomic,copy) NSString *userName; //用户名字
@property (nonatomic,copy) NSString *userRellyName; //用户真名
@property (nonatomic,copy) NSString *userMobile; //用户手机
@property (nonatomic,copy) NSString *userPassWord; //用户密码
@property (nonatomic,copy) NSString *userID; //用户ID
@property (nonatomic,copy) NSString *userSex; //用户性别
@property (nonatomic,copy) NSString *userProvinces; //用户省份
@property (nonatomic,copy) NSString *userCity; //用户城市
@property (nonatomic,copy) NSString *userCityPosition;//用户城市定位
@property (nonatomic,copy) NSString *userStreet; //用户区
@property (nonatomic,copy) NSString *userArea; //用户城市区域
@property (nonatomic,copy) NSString *userToken;//用户Token标识
@property (nonatomic,copy) NSString *userLatitude;//用户纬度
@property (nonatomic,copy) NSString *userLongitude;//用户经度
@property (nonatomic,copy) NSString *userCityID;//用户城市ID

@property (nonatomic) BOOL openNotification;//是否打开推送
@property (nonatomic,copy) NSString *style;//样式
@property (nonatomic,copy) NSString *userEmail; //用户邮箱
@property (nonatomic) BOOL isBackup;//是否备份
//测试
@property (nonatomic,copy) NSArray *fontArry;//

@end
