//
//  TransGPS.m
//  BigDiaoMan
//
//  Created by xjkj on 14-8-12.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import "TransGPS.h"
#import "CSqlite.h"

@interface TransGPS (){
   
}
@end

@implementation TransGPS
////转换坐标      //CLLocationCoordinate2D New=[self zzTransGPS:coordinata];//火星坐标

+(CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
{
    CSqlite *m_sqlite;
    int TenLat=0;
    int TenLog=0;
    TenLat = (int)(yGps.latitude*10);
    TenLog = (int)(yGps.longitude*10);
    NSString *sql = [[NSString alloc]initWithFormat:@"select offLat,offLog from gpsT where lat=%d and log = %d",TenLat,TenLog];
    sqlite3_stmt* stmtL = [m_sqlite NSRunSql:sql];
    int offLat=0;
    int offLog=0;
    while (sqlite3_step(stmtL)==SQLITE_ROW)
    {
        offLat = sqlite3_column_int(stmtL, 0);
        offLog = sqlite3_column_int(stmtL, 1);
        
    }
    
    yGps.latitude = yGps.latitude+offLat*0.0001;
    yGps.longitude = yGps.longitude + offLog*0.0001;
    NSLog(@"yGps%f  %f",yGps.latitude,yGps.longitude);
    return yGps;
  
}

@end
