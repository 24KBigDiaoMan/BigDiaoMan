//
//  MapViewController.m
//  APP
//
//  Created by zmx on 14-2-20.
//  Copyright (c) 2014年 zmx. All rights reserved.
//

#import "MapViewController.h"
#import "MobilePosition.h"
#import "SettingsManager.h"
#import "JPSThumbnailAnnotation.h"


@interface MapViewController ()

@property(retain,nonatomic)MKMapView *mapView;
@property(nonatomic,retain)CLLocationManager *locationManager;//用户地址管理
@end

@implementation MapViewController



-(void)viewWillDisappear:(BOOL)animated
{
 
    [super viewWillDisappear:animated];
    
    
}
-(void)backTo:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)address:(UIButton*)sender
{
    [self starMyAdress];


}
-(void)starMyAdress
{	
    //开始定位
    [[MobilePosition shardMobilePosition]startAddress];
    
    [MobilePosition shardMobilePosition].mobilePositionRetureYES=^(void)
    {
       
        CLLocationCoordinate2D  coordinata=CLLocationCoordinate2DMake([[SettingsManager shardSettingsManager].userLatitude floatValue],
                                                                      [[SettingsManager shardSettingsManager].userLongitude floatValue]);
        MKCoordinateSpan  span=MKCoordinateSpanMake(0.07, 0.07);
        
        [self.mapView setRegion:MKCoordinateRegionMake(coordinata, span) animated:YES];
        
       
        [Methods performBlock:^{
            
            //添加商户
            [self.mapView addAnnotations:[self addCountPoint]];
        } afterDelay:3];
        
        
    };
    
    [MobilePosition shardMobilePosition].mobilePositionRetureNO=^(void)
    {
        
        CLog(@"定位失败");
        
        
    };
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    // 创建地图24.489084 118.103338
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation=YES;
    [self.view addSubview:self.mapView];
    
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    back.frame=CGRectMake(10, 20, 40, 40);
    [back setImage:SystemQuickImage(@"back.png") forState:UIControlStateNormal];
    [back setImage:SystemQuickImage(@"backSelected.png") forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(backTo:) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:back];
    
//    UIButton *address=[UIButton buttonWithType:UIButtonTypeCustom];
//    address.frame=CGRectMake(20, self.mapView.frame.size.height-80, 40, 40);
//    [address setImage:SystemQuickImage(@"map_mys.png") forState:UIControlStateNormal];
//    [address setImage:SystemQuickImage(@"map_mys_s.png") forState:UIControlStateHighlighted];
//    [address addTarget:self action:@selector(address:) forControlEvents:UIControlEventTouchUpInside];
//    [self.mapView addSubview:address];
    

    self.dataArry =@[@"http://img0.bdstatic.com/img/image/shouye/leimu/mingxing2.jpg",
                     @"http://img0.bdstatic.com/img/image/shouye/leimu/mingxing2.jpg",
                     @"http://img0.bdstatic.com/img/image/shouye/leimu/mingxing2.jpg",
                     @"http://img0.bdstatic.com/img/image/shouye/leimu/mingxing2.jpg",
                     @"http://img0.bdstatic.com/img/image/shouye/leimu/mingxing2.jpg",
                     @"http://img0.bdstatic.com/img/image/shouye/leimu/mingxing2.jpg",
                     @"http://img0.bdstatic.com/img/image/shouye/leimu/mingxing2.jpg"];
   

    [self starMyAdress];//定位
    
   
}


//添加商户
-(NSArray *)addCountPoint
{
    NSMutableArray *annotations = [[NSMutableArray alloc] initWithCapacity:15];
 
    for (int i=0; i<self.dataArry.count; i++)
    {
       
        JPSThumbnail *empire = [[JPSThumbnail alloc] init];
        empire.image = [UIImage imageNamed:@"bg0.jpg"];
        empire.title = @"你好";
        empire.subtitle = @"18750596025";
        CLLocationCoordinate2D  coordinata=CLLocationCoordinate2DMake([[SettingsManager shardSettingsManager].userLatitude floatValue]+i*0.01,
                                                                      [[SettingsManager shardSettingsManager].userLongitude floatValue]+i*0.001);
        
        empire.coordinate = coordinata;
        
        empire.disclosureBlock = ^{
            CLog(@"dis");
        };
        [annotations addObject:[JPSThumbnailAnnotation annotationWithThumbnail:empire]];
    }
    
    
    return annotations;
}


#pragma mark - MKMapViewDelegate
#pragma mark 点击地图上得view
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}
#pragma mark 点击地图上得其他view
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
    }
}
#pragma mark 创建view
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}
@end
