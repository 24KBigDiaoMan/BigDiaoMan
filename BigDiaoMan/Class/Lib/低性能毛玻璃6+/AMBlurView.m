//
//  AMBlurView.m
//  blur
//
//  Created by Cesar Pinto Castillo on 7/1/13.
//  Copyright (c) 2013 Arctic Minds Inc. All rights reserved.
//

#import "AMBlurView.h"
#import <QuartzCore/QuartzCore.h>

@interface AMBlurView ()

@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation AMBlurView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        CLog(@"initWithCoder");
        [self setup];
        self.userInteractionEnabled=YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        CLog(@"init");
        [self setup];
    }
    return self;
}

- (void)setup {
    // If we don't clip to bounds the toolbar draws a thin shadow on top
    [self setClipsToBounds:YES];
    if (![self toolbar])
    {
        [self setToolbar:[[UIToolbar alloc] initWithFrame:[self bounds]]];
        [self.layer insertSublayer:[self.toolbar layer] atIndex:0];
    }
}

- (void) setBlurTintColor:(UIColor *)blurTintColor {
    
    if (IOS_VERSION_7_OR_ABOVE) {
        [self.toolbar setBarTintColor:blurTintColor];
    } else
    {
        UIImage *toolBarIMG = [UIImage imageNamed:IOS6_5_BGImage];
        
        if ([self.toolbar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)])
        {
            [self.toolbar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
        }
       
//        [self.toolbar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:IOS6_5_BGImage]]];
   
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.toolbar setFrame:[self bounds]];
}

@end
