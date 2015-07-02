//
//  ReadViewController.m
//  BigDiaoMan
//
//  Created by xjkj on 14-7-25.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import "ReadViewController.h"

#import <AVFoundation/AVFoundation.h>


@interface ReadViewController ()
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(assign)BOOL allocY;
@property(assign)BOOL sayY;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@end

@implementation ReadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)touchLeftBnt:(UIButton *)sender{

    [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchRightBnt:(UIButton *)sender{
    
    if (!self.allocY) {
        
        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.textView.text];
        [self.synthesizer speakUtterance:utterance];
        self.sayY=YES;
        self.allocY=YES;
        CLog(@"创建");
    }
    
    
   
    if (self.sayY) {
         [self.rightButton setImage:SystemQuickImage(@"icon_listheader_animation_2.png") forState:UIControlStateNormal];
         [self.synthesizer continueSpeaking];
          self.sayY=NO;
            CLog(@"读书");
    }else{
     
            CLog(@"不读书");
        [self.rightButton setImage:SystemQuickImage(@"icon_listheader_animation_1.png") forState:UIControlStateNormal];
        [self.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
         self.sayY=YES;
    }
   
  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.title=@"有声读物";
    [self.rightButton setImage:SystemQuickImage(@"icon_listheader_animation_1.png")
                                     forState:UIControlStateNormal];
    self.allocY=NO;
    self.sayY=NO;
    //准备创建读书的人
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
   
    
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   

   
    
}

/*
//#pragma mark - UINavigationControllerDelegate
 //#import "HUTransitionAnimator.h"
 //#import "ZBFallenBricksAnimator.h"
 //#import "UIImage+ImageEffects.h"
//type = TransitionTypeNormal;
 TransitionType type;
 typedef enum {
 TransitionTypeNormal,
 TransitionTypeVerticalLines,
 TransitionTypeHorizontalLines,
 TransitionTypeGravity,
 } TransitionType;
// //self.navigationController.delegate = self;
//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                  animationControllerForOperation:(UINavigationControllerOperation)operation
//                                               fromViewController:(UIViewController *)fromVC
//                                                 toViewController:(UIViewController *)toVC
//{
//    NSObject <UIViewControllerAnimatedTransitioning> *animator;
//    
//    switch (type) {
//        case TransitionTypeVerticalLines:
//            animator = [[HUTransitionVerticalLinesAnimator alloc] init];
//            [(HUTransitionAnimator *)animator setPresenting:NO];
//            break;
//        case TransitionTypeHorizontalLines:
//            animator = [[HUTransitionHorizontalLinesAnimator alloc] init];
//            [(HUTransitionAnimator *)animator setPresenting:NO];
//            break;
//        case TransitionTypeGravity:
//            animator = [[ZBFallenBricksAnimator alloc] init];
//            break;
//        default:
//            animator = nil;
//    }
//    
//    return animator;
//}
 */
@end
