//
//  JJNavigationController.h
//  ShengLoveParadise
//
//  Created by xjkj on 14-5-16.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJNavigationController : UINavigationController

// Enable the drag to back interaction, Defalt is YES.
@property (nonatomic,assign) BOOL canDragBack;
@property (nonatomic,strong) UIPanGestureRecognizer *recognizer;
@end
