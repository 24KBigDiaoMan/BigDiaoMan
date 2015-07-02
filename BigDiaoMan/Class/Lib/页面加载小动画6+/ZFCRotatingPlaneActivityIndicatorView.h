/*
 
 
 
 
 ZFCRotatingPlaneActivityIndicatorView *rotatingPlane = [[ZFCRotatingPlaneActivityIndicatorView alloc] init];
 rotatingPlane.planeColor=[UIColor redColor];
 rotatingPlane.center = CGPointMake(UIScreenWidth/2, 200);
 [rotatingPlane startAnimating];
 [self.view addSubview:rotatingPlane];
 
 
 
 */
#import <UIKit/UIKit.h>

@interface ZFCRotatingPlaneActivityIndicatorView : UIView

/**
 正方形的颜色
 */
@property (readwrite,nonatomic) UIColor *planeColor;
/**
 正方形的边长
 */
@property (readwrite, nonatomic) CGFloat sideLength;
/**
 设置动画持续时间
 */
@property (readwrite, nonatomic) CGFloat duration;
/**
 设置透视距离
 */
@property (readwrite, nonatomic) CGFloat perspectiveValue;

- (void)startAnimating;

- (void)stopAnimating;

@end
