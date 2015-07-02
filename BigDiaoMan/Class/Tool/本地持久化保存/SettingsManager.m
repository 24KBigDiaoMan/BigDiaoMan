//
//  SettingsManager.m
//  APP
//
//  Created by zmx on 14-1-13.
//  Copyright (c) 2014年 zmx. All rights reserved.
//
static NSString *ZMX_Frist_Run = @"Frist_Run";
static NSString *ZMX_Frist_Enter = @"ZMX_Frist_Enter";
static NSString *ZMX_ISRemberPassWord = @"ZMX_ISRemberPassWord";
static NSString *ZMX_IsLogInEnter = @"ZMX_IsLogInEnter";
static NSString *ZMX_SystemVersion = @"ZMX_SystemVersion";
static NSString *ZMX_UserType = @"ZMX_UserType";
static NSString *ZMX_UserName = @"UserName";
static NSString *ZMX_UserRellyName = @"ZMX_UserRellyName";
static NSString *ZMX_UserMobile = @"ZMX_UserMobile";
static NSString *ZMX_UserPassWord = @"ZMX_UserPassWord";
static NSString *ZMX_UserID = @"ZMX_UserID";
static NSString *ZMX_UserSex = @"ZMX_UserSex";
static NSString *ZMX_UserProvinces = @"ZMX_UserProvinces";
static NSString *ZMX_UserCity = @"ZMX_UserCity";
static NSString *ZMX_UserCityPosition = @"ZMX_UserCityPosition";
static NSString *ZMX_UserCityStreet = @"ZMX_UserCityStreet";
static NSString *ZMX_UserArea = @"ZMX_UserArea";
static NSString *ZMX_UserToken = @"ZMX_UserToken";
static NSString *ZMX_UserLatitude = @"ZMX_UserLatitude";
static NSString *ZMX_UserLongitude = @"ZMX_UserLongitude";
static NSString *ZMX_UserCityID = @"ZMX_UserCityID";
static NSString *ZMX_OpenNotification = @"ZMX_OpenNotification";
static NSString *ZMX_IsBackup = @"ZMX_IsBackup";
static NSString *ZMX_Style = @"ZMX_Style";
static NSString *ZMX_UserEmail = @"ZMX_UserEmail";
static NSString *ZMX_FontArry = @"ZMX_FontArry";
#import "SettingsManager.h"
@interface SettingsManager()

@property (nonatomic, retain) NSUserDefaults *userDefaults;

@end

@implementation SettingsManager


static SettingsManager *settingsManager=nil;

#pragma -mark ------------------------初始化------------------------
+(SettingsManager *)shardSettingsManager
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        settingsManager = [[self alloc] init];
        
    });
    return settingsManager;
}
-(id)init
{
    if (self = [super init])
    {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        NSObject *firstObject = [self.userDefaults objectForKey:ZMX_Frist_Run];
        if (firstObject == nil)
        {
            self.isFirstRun = YES;
        }
        else
        {
            self.isFirstRun = NO;
        }
        //
        [self.userDefaults synchronize];
    }
    return self;
}
#pragma -mark ------------------------初始化------------------------
//第一次开启配置
- (BOOL)isFirstRun
{
    return [self.userDefaults boolForKey:ZMX_Frist_Run];
}

- (void)setIsFirstRun:(BOOL)value
{
    [self.userDefaults setBool:value forKey:ZMX_Frist_Run];
    [self.userDefaults synchronize];
}

//是否记住密码
- (BOOL)isRemberPassWord
{
    return [self.userDefaults boolForKey:ZMX_ISRemberPassWord];
}

- (void)setIsRemberPassWord:(BOOL)isRemberPassWord
{
    [self.userDefaults setBool:isRemberPassWord forKey:ZMX_ISRemberPassWord];
    [self.userDefaults synchronize];
}
//是否登入

-(BOOL )isLogInEnter
{
    return [self.userDefaults boolForKey:ZMX_IsLogInEnter];
}
-(void)setIsLogInEnter:(BOOL)isLogInEnter
{
    [self.userDefaults setBool:isLogInEnter forKey:ZMX_IsLogInEnter];
    [self.userDefaults synchronize];
}

//是否是第一次进入程序
-(BOOL)isFirstEnter
{
    return [self.userDefaults boolForKey:ZMX_Frist_Enter];
}
-(void)setIsFirstEnterEnter:(BOOL)isFirstEnter
{
    [self.userDefaults setBool:isFirstEnter forKey:ZMX_Frist_Enter];
    [self.userDefaults synchronize];
}
#pragma -mark 系统版本
-(NSString*)systemVersion
{
    return [self.userDefaults stringForKey:ZMX_SystemVersion];
}
-(void)setSystemVersion:(NSString *)systemVersion
{
    [self.userDefaults setObject:systemVersion forKey:ZMX_SystemVersion];
    [self.userDefaults synchronize];
}
//用户类型
-(NSString*)userType
{
    return [self.userDefaults stringForKey:ZMX_UserType];
}
-(void)setUserType:(NSString *)userType
{
    [self.userDefaults setObject:userType forKey:ZMX_UserType];
    [self.userDefaults synchronize];
}
//用户名字
-(NSString*)userName
{
    return [self.userDefaults stringForKey:ZMX_UserName];
}
-(void)setUserName:(NSString *)userName
{
    [self.userDefaults setObject:userName forKey:ZMX_UserName];
    [self.userDefaults synchronize];
}

//用户真名
-(NSString*)userRellyName
{
    return [self.userDefaults stringForKey:ZMX_UserRellyName];
}
-(void)setUserRellyName:(NSString *)userRellyName
{
    [self.userDefaults setObject:userRellyName forKey:ZMX_UserRellyName];
    [self.userDefaults synchronize];
}

//用户手机
-(NSString*)userMobile
{
    return [self.userDefaults stringForKey:ZMX_UserMobile];
}
-(void)setUserMobile:(NSString *)userMobile
{
    [self.userDefaults setObject:userMobile forKey:ZMX_UserMobile];
    [self.userDefaults synchronize];
}

//用户密码
-(NSString*)userPassWord
{
    return [self.userDefaults stringForKey:ZMX_UserPassWord];
}
-(void)setUserPassWord:(NSString *)userPassWord
{
    [self.userDefaults setObject:userPassWord forKey:ZMX_UserPassWord];
    [self.userDefaults synchronize];
}
//用户ID
-(NSString*)userID
{
    return [self.userDefaults stringForKey:ZMX_UserID];
}
-(void)setUserID:(NSString *)userID
{
    [self.userDefaults setObject:userID forKey:ZMX_UserID];
    [self.userDefaults synchronize];
}
//用户性别
-(NSString*)userSex
{
    return [self.userDefaults stringForKey:ZMX_UserSex];
}
-(void)setUserSex:(NSString *)userSex
{
    [self.userDefaults setObject:userSex forKey:ZMX_UserSex];
    [self.userDefaults synchronize];
}

//用户省份
-(NSString*)userProvinces
{
    return [self.userDefaults stringForKey:ZMX_UserProvinces];
}
-(void)setUserProvinces:(NSString *)userProvinces
{
    [self.userDefaults setObject:userProvinces forKey:ZMX_UserProvinces];
    [self.userDefaults synchronize];
}

//用户城市
-(NSString*)userCity
{
    return [self.userDefaults stringForKey:ZMX_UserCity];
}
-(void)setUserCity:(NSString *)userCity
{
    [self.userDefaults setObject:userCity forKey:ZMX_UserCity];
    [self.userDefaults synchronize];
}
//用户城市定位
-(NSString*)userCityPosition
{
    return [self.userDefaults stringForKey:ZMX_UserCityPosition];
}
-(void)setUserCityPosition:(NSString *)userCityPosition
{
    [self.userDefaults setObject:userCityPosition forKey:ZMX_UserCityPosition];
    [self.userDefaults synchronize];
}
//用户街道定位
-(NSString*)userStreet
{
    return [self.userDefaults stringForKey:ZMX_UserCityStreet];
}
-(void)setUserStreet:(NSString *)userStreet
{
    [self.userDefaults setObject:userStreet forKey:ZMX_UserCityStreet];
    [self.userDefaults synchronize];
}
//用户城市区域
-(NSString*)userArea
{
    return [self.userDefaults stringForKey:ZMX_UserArea];
}
-(void)setUserArea:(NSString *)userArea
{
    [self.userDefaults setObject:userArea forKey:ZMX_UserArea];
    [self.userDefaults synchronize];
}
//userToken
-(NSString*)userToken
{
    return [self.userDefaults stringForKey:ZMX_UserToken];
}
-(void)setUserToken:(NSString *)userToken
{
    [self.userDefaults setObject:userToken forKey:ZMX_UserToken];
    [self.userDefaults synchronize];
}
//用户纬度

-(NSString*)userLatitude
{
    return [self.userDefaults stringForKey:ZMX_UserLatitude];
}
-(void)setUserLatitude:(NSString *)userLatitude
{
    [self.userDefaults setObject:userLatitude forKey:ZMX_UserLatitude];
    [self.userDefaults synchronize];
}

//用户经度
-(NSString*)userLongitude
{
    return [self.userDefaults stringForKey:ZMX_UserLongitude];
}
-(void)setUserLongitude:(NSString *)userLongitude
{
    [self.userDefaults setObject:userLongitude forKey:ZMX_UserLongitude];
    [self.userDefaults synchronize];
}

//用户城市ID
-(NSString*)userCityID
{
    return [self.userDefaults stringForKey:ZMX_UserCityID];
}
-(void)setUserCityID:(NSString *)userCityID
{
    [self.userDefaults setObject:userCityID forKey:ZMX_UserCityID];
    [self.userDefaults synchronize];
}
#pragma -mark----- 是否打开夜间免打扰 -----
-(BOOL)openNotification
{
    return [self.userDefaults boolForKey:ZMX_OpenNotification];
}

- (void)setOpenNotification:(BOOL)openNotification
{
    [self.userDefaults setBool:openNotification forKey:ZMX_OpenNotification];
    [self.userDefaults synchronize];
}

//样式
-(NSString*)style
{
    return [self.userDefaults stringForKey:ZMX_Style];
}
-(void)setStyle:(NSString *)style
{
    [self.userDefaults setObject:style forKey:ZMX_Style];
    [self.userDefaults synchronize];
}
//邮箱
-(NSString*)userEmail
{
    return [self.userDefaults stringForKey:ZMX_UserEmail];
}
-(void)setUserEmail:(NSString *)userEmail
{
    [self.userDefaults setObject:userEmail forKey:ZMX_UserEmail];
    [self.userDefaults synchronize];
}

#pragma -mark----- 是否备份 -----
-(BOOL)isBackup
{
    return [self.userDefaults boolForKey:ZMX_IsBackup];
}

- (void)setIsBackup:(BOOL)isBackup
{
    [self.userDefaults setBool:isBackup forKey:ZMX_IsBackup];
    [self.userDefaults synchronize];
}



-(NSArray*)fontArry
{
    return [self.userDefaults arrayForKey:ZMX_FontArry];
}
-(void)setFontArry:(NSArray *)fontArry
{
    [self.userDefaults setObject:fontArry forKey:ZMX_FontArry];
    [self.userDefaults synchronize];
}
@end
