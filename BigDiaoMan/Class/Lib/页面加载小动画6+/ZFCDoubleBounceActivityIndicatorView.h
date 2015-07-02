/*
 
 
 
 ZFCDoubleBounceActivityIndicatorView *doubleBounce = [[ZFCDoubleBounceActivityIndicatorView alloc] init];
 doubleBounce.center = CGPointMake(UIScreenWidth*1.5, 200);
 [doubleBounce startAnimating];
 [scrollView addSubview:doubleBounce];
 
 
 
 */
#import <UIKit/UIKit.h>

@interface ZFCDoubleBounceActivityIndicatorView : UIView
/**
 设置颜色
 */
@property (readwrite, nonatomic) UIColor *bounceColor;
/**
 设置半径
 */
@property (readwrite, nonatomic) CGFloat radius;
/**
 设置动画延迟
 */
@property (readwrite, nonatomic) CGFloat delay;
/**
 设置动画持续时间
 */
@property (readwrite, nonatomic) CGFloat duration;

- (void)startAnimating;

- (void)stopAnimating;

@end
