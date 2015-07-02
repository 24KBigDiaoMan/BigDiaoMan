//
//  MobilePosition.h
//  APP
//
//  Created by zmx on 14-1-28.
//  Copyright (c) 2014年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MobilePosition : NSObject<CLLocationManagerDelegate>

typedef void (^MobilePositionRetureYES)(void);
@property (copy)MobilePositionRetureYES mobilePositionRetureYES;

typedef void (^MobilePositionRetureNO)(void);
@property (copy)MobilePositionRetureNO mobilePositionRetureNO;

+(MobilePosition *)shardMobilePosition;
@property(nonatomic,retain)CLLocationManager *locationManager;//用户定位管理
-(void)startAddress;

@end
