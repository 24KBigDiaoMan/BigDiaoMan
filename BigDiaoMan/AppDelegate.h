//
//  AppDelegate.h
//  BigDiaoMan
//
//  Created by xjkj on 14-5-16.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTabBarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//********************UINavigationController*************************

@property(strong, nonatomic)UINavigationController *navigationController;
@property(strong, nonatomic)RootTabBarViewController *rootViewController;

//********************coredata*************************
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
