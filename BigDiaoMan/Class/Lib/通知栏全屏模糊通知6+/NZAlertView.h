/*
 
 
 
 //    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleSuccess
 //                                             statusBarColor:RGB(123, 55, 66, 1)
 //                                                      title:@"1231"
 //                                                    message:@"12321"];
 //
 //
 //
 //    [alert showWithCompletion:^{
 //        NSLog(@"结束");
 //
 //    }];
 //
 //    alert.willAppear=^(NZAlertView *alertView){
 //        NSLog(@"willAppear");
 //    };
 //    alert.didAppear=^(NZAlertView *alertView){
 //        NSLog(@"didAppear");
 //    };
 //    alert.willDismiss=^(NZAlertView *alertView){
 //        NSLog(@"willDismiss");
 //    };
 //    alert.didDismiss=^(NZAlertView *alertView){
 //        NSLog(@"didDismiss");
 //    };
 
 
 }
 
 #pragma mark -
 #pragma mark - Private methods
 
 - (void)imageAnimation
 {
 CATransition *transition = [CATransition animation];
 
 transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
 transition.duration = 1.5f;
 transition.type = @"rippleEffect";
 
 [[self.imageView layer] addAnimation:transition forKey:@"rippleEffect"];
 }

 */

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>
typedef NS_ENUM(NSInteger, NZAlertStyle) {
    NZAlertStyleError = 0,
    NZAlertStyleSuccess,
    NZAlertStyleInfo
};

typedef void(^NZAlertViewCompletion)(void);

@interface NZAlertView : UIView

//@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) NZAlertStyle alertViewStyle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, readonly, getter = isVisible) BOOL visible;
@property (nonatomic, copy) UIColor *statusBarColor;

- (id)initWithStyle:(NZAlertStyle)style
     statusBarColor:(UIColor *)statusBarColor
              title:(NSString *)title
            message:(NSString *)message;

//弹出
- (void)show;
//弹出回调
- (void)showWithCompletion:(NZAlertViewCompletion)completion;


//即将出现
typedef void (^NZWillAppear)(NZAlertView *alertView);
@property (copy)NZWillAppear willAppear;
//出现
typedef void (^NZDidAppear)(NZAlertView *alertView);
@property (copy)NZDidAppear didAppear;
//即将消失
typedef void (^NZWillDismiss)(NZAlertView *alertView);
@property (copy)NZWillDismiss willDismiss;
//消失
typedef void (^NZDidDismiss)(NZAlertView *alertView);
@property (copy)NZDidDismiss didDismiss;
@end