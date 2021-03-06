/*
 
 
 ZFCWanderingCubesActivityIndicatorView *wanderingCubes = [[ZFCWanderingCubesActivityIndicatorView alloc] init];
 wanderingCubes.center = CGPointMake(UIScreenWidth*3.5, 200);
 [wanderingCubes startAnimating];
 [scrollView addSubview:wanderingCubes];
 
 
 */
#import <UIKit/UIKit.h>

@interface ZFCWanderingCubesActivityIndicatorView : UIView

/**
 设置第一个方块的颜色
 */
@property (readwrite, nonatomic) UIColor *firstCubeColor;
/**
 设置第二个方块的颜色
 */
@property (readwrite, nonatomic) UIColor *secondCubeColor;
/**
 设置动画的持续时间
 */
@property (readwrite, nonatomic) CGFloat duration;
/**
 设置两个方块动画的延迟时间
 */
@property (readwrite, nonatomic) CGFloat delay;
/**
 设置方块的大小
 */
@property (readwrite, nonatomic) CGFloat cubeWidth;
/**
 设置方块的移动距离
 */
@property (readwrite, nonatomic) CGFloat moveWidth;

- (void)startAnimating;

- (void)stopAnimating;

@end
