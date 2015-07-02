//
//  MapViewController.h
//  APP
//
//  Created by zmx on 14-2-20.
//  Copyright (c) 2014年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
@property(strong,nonatomic)NSArray *dataArry;
@end
