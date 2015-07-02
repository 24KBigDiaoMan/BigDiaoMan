//
//  MobilePosition.m
//  APP
//
//  Created by zmx on 14-1-28.
//  Copyright (c) 2014年 zmx. All rights reserved.
//

#import "MobilePosition.h"
#import "SettingsManager.h"
static MobilePosition *mobilePosition=nil;
@implementation MobilePosition

+(MobilePosition *)shardMobilePosition
{
    // 只初始化一次
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        mobilePosition = [[self alloc] init];
    
    });
    return mobilePosition;
}

#pragma -mark ---------------开始定位--------------
-(void)startAddress
{
    if (!self.locationManager)
    {
        //定义用户位置获取数据
        self.locationManager=[[CLLocationManager alloc]init];
        self.locationManager.delegate=self;
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        self.locationManager.distanceFilter=100.0f;
        
        if (IsIOS8) {
            [self.locationManager startMonitoringSignificantLocationChanges];
            
            [self.locationManager requestAlwaysAuthorization];
        }
        
    }
    
   
    //开启坐标管理
    [self.locationManager startUpdatingLocation];

}

/*
//获得城市ID
-(void)getCityAndCityID:(NSString *)locality
{

    //根据本地城市存储数据文件来匹配定位地址的ID
    NSMutableArray *cityData=[[NSMutableArray alloc]init];
    NSMutableArray *cityIdData=[[NSMutableArray alloc]init];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"citydata" ofType:@"plist"];
    NSArray *allArry = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    
    
    for (int i=0; i<allArry.count; i++)
    {
        NSArray *cityArry=[[allArry objectAtIndex:i]objectForKey:@"citylist"];
        for (int i=0; i<cityArry.count; i++)
        {
            
            [cityIdData addObject:[[cityArry objectAtIndex:i]objectForKey:@"id"]];
            NSString *str=[[cityArry objectAtIndex:i]objectForKey:@"cityName"];
            [cityData addObject: str];
            
        }
        
    }
    
    if ([cityData  containsObject:locality])
    {
        
        [[SettingsManager shardSettingsManager]setUserCityID:[cityIdData objectAtIndex:[cityData indexOfObject:locality]]];
        [[SettingsManager shardSettingsManager]setUserCity:[cityData objectAtIndex:[cityData indexOfObject:locality]]];
        [[SettingsManager shardSettingsManager]setUserCityPosition:[cityData objectAtIndex:[cityData indexOfObject:locality]]];
        

        
            CLog(@"人工获取城市:%@城市ID:%@",
                 [SettingsManager shardSettingsManager].userCity,
                 [SettingsManager shardSettingsManager].userCityID);
        
            CLog(@"当前坐标%@ %@ 街道%@",
                 [SettingsManager shardSettingsManager].userLatitude,
                 [SettingsManager shardSettingsManager].userLongitude,
                 [SettingsManager shardSettingsManager].userStreet);
        
        //匹配成功
        if (self.mobilePositionRetureYES)
        {
            self.mobilePositionRetureYES();
        }
        
    }else
    {
      
          //匹配失败
        if (self.mobilePositionRetureNO)
        {
            self.mobilePositionRetureNO();
        }
    }
    

}
*/

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
            
        casekCLAuthorizationStatusNotDetermined:
            
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                
                [self.locationManager requestAlwaysAuthorization];
            }
            
            break;
        default:
            break;
            
            
    } 
}
// ios6以上点击允许定位成功
- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
    
    
    
    if (locations)
    {
        CLLocation *userLoc=(CLLocation*)[locations lastObject];
     
        
        [[SettingsManager shardSettingsManager] setUserLatitude:
         [NSString stringWithFormat:@"%f",userLoc.coordinate.latitude]];
        [[SettingsManager shardSettingsManager] setUserLongitude:
         [NSString stringWithFormat:@"%f",userLoc.coordinate.longitude]];
        
        CLog(@"%@--%@",[SettingsManager shardSettingsManager].userLatitude,[SettingsManager shardSettingsManager].userLongitude);
        if (self.mobilePositionRetureYES)
        {
            self.mobilePositionRetureYES();
        }
        CLLocation *newLocation=[[CLLocation alloc]initWithLatitude:userLoc.coordinate.latitude longitude:userLoc.coordinate.longitude];

        
        //获得城市
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark * placemark in placemarks) {
                
                
                //存储街道
                [[SettingsManager shardSettingsManager] setUserStreet:[placemark name]];
                //匹配ID
                //NSString *test = [placemark locality];
                //[self getCityAndCityID:test];
                
            }
        }];
        
    }
    
    [self.locationManager stopUpdatingLocation];
    
}


//定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error)
    {
      
        if (self.mobilePositionRetureNO)
        {
            self.mobilePositionRetureNO();
        }
        
    }
    CLog(@"%@",[NSString stringWithFormat:@"%ld",(long)error.code]);
    if (error.code == kCLErrorDenied)
    {
       
    // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }

}
@end
