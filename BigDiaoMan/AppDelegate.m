//
//  AppDelegate.m
//  ProductShow
//
//  Created by xjkj on 14-10-17.
//  Copyright (c) 2014年 HandSomeMan. All rights reserved.
//

#import "AppDelegate.h"
#import "UINavigationController+MHDismissModalView.h"

//#import "UMSocial.h"//$(ARCHS_STANDARD)
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
#pragma -mark- -----------UIApplication-----------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    //导航
    [self navSetUp];
    //配置
    [self setUpFrist];
    
    //注册通知
    [self setPushNotificationWithOptions:launchOptions];
    
    //友盟
    //[self youMeng];
    
    return YES;
}
#pragma -mark- -----------第一次运行程序配置-----------
-(void)setUpFrist{
    
    
    //程序第一次进入设置 或者升级
    if (![[SettingsManager shardSettingsManager].systemVersion isEqualToString:[Methods programInformation:@"CFBundleShortVersionString"]] )
    {
        
        [[SettingsManager shardSettingsManager]setSystemVersion:[Methods programInformation:@"CFBundleShortVersionString"]];
        
        
        //用户未登录
        [[SettingsManager shardSettingsManager]setIsLogInEnter:NO];
        //默认关闭推送
        [[SettingsManager shardSettingsManager] setOpenNotification:NO];
        [[SettingsManager shardSettingsManager] setStyle:@"1"];
        
        //绑定邮箱去掉
        [[SettingsManager shardSettingsManager] setUserEmail:@""];
        [[SettingsManager shardSettingsManager]setIsRemberPassWord:NO];
        
    }
    
    //主界面
    [self makeInitializationMain];
    
//    if ([SettingsManager shardSettingsManager].isLogInEnter) {
//      
//    }else{
//        //登陆界面
//        [self makeInitializationLogin];
//    }
    
}
#pragma -mark- -----------导航配置-----------
-(void)navSetUp{

    //导航栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
   // [[UINavigationBar appearance] setBarTintColor:RGB(138, 195, 93, 1)];
    
    NSDictionary *dic=@{NSForegroundColorAttributeName :RGB(1, 1, 1, 1),
                        NSFontAttributeName:SystemFont(19)};
    //中间文字颜色
    [[UINavigationBar appearance]setTitleTextAttributes:dic];
    
    
    //    //导航图片背景
    //    UIImage *bgImage=[[UIImage imageNamed:@"每日推荐-标题栏背景.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //    [[UINavigationBar appearance] setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    [[UITextField appearance]setTintColor:RGB(138, 195, 93, 1)];
    [[UITextView appearance]setTintColor:RGB(138, 195, 93, 1)];
    
    
//    //弹出模态试图设置
//    [[MHDismissSharedManager sharedDismissManager]installWithTheme:MHModalThemeExtraWhite
//                                                   withIgnoreBlock:^(MHDismissIgnore *ignore) {
//                                                       
//                                                       if ([ignore.viewControllerName isEqualToString:@"SetUpViewController"]) {
//                                                           //ignore.ignoreGesture = YES;
//                                                           //ignore.ignoreBlurEffect = NO;
//                                                       }
//                                                       
//                                                       
//                                                   }];
}

#pragma -mark- -----------登陆界面加载-----------
-(void)makeInitializationLogin{
    
//    __weak AppDelegate *app=self;
//    //rootUI设置
//    self.loginViewController=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//    self.loginViewController.loginSuccessful=^(void){
//        [app makeInitializationMain];
//    };
//    self.navigationController=[[UINavigationController alloc]initWithRootViewController:self.loginViewController];
//    //系统自带返回
//    self.loginViewController.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    
//    self.window.rootViewController=self.navigationController;
    
    
}

#pragma -mark- -----------主界面加载-----------
-(void)makeInitializationMain{
    
    
    //rootUI设置
    self.rootViewController=[[RootTabBarViewController alloc]initWithNibName:@"RootTabBarViewController" bundle:nil];
    self.navigationController=[[UINavigationController alloc]initWithRootViewController:self.rootViewController];
    self.rootViewController.navigationController.navigationBarHidden=YES;
    self.window.rootViewController=self.navigationController;
    
    
}
#pragma -mark- -----------注册通知-----------
-(void)setPushNotificationWithOptions:(NSDictionary *)launchOptions{
    //判断程序是由推送服务完成的
    if (launchOptions)
    {
        NSDictionary* pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (pushNotificationKey)
        {
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            //这是通过推送窗口启动的程序，你可以在这里处理推送内容
        }
        
        
    }
    
    if (IsIOS8) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil]];
        
    }else{
        /** 注册推送通知功能, */
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }
}

#pragma mark - 实现远程推送需要实现的监听接口
/** 接收从苹果服务器返回的唯一的设备token，该token需要发送回推送服务器*/
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[SettingsManager shardSettingsManager] setOpenNotification:YES];
    
    CLog(@"注册推送功能时生成的devToken:%@", deviceToken);
    // [self saveDeviceToken: [NSString stringWithFormat:@"%@",deviceToken]];
    
}
#pragma mark 保存deviceToken到服务器
-(void)saveDeviceToken:(NSString*)token{
    AFHTTPRequestOperationManager *manager = [AFNetwork shareAFHTTPClient];
    // 参数
    NSDictionary *dic=@{@"device-token":token,
                        @"push-status":@"true"};
    
    AFHTTPRequestOperation*   post;
    post=[manager POST:@"service/push/notification"
            parameters:dic
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   
                   [AFNetwork getHTTPSuccessful:operation
                                stateSuccessful:^(NSDictionary *successfulDic) {
                                    
                                    
                                    
                                } stateFailure:^(NSDictionary *failureDic) {
                                    
                                }];
                   
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   
                   
                   [AFNetwork getHTTPFailure:error
                                stateFailure:^(NSDictionary *failureDic) {
                                    
                                }];
               }];
    
}


/** 接收注册推送通知功能时出现的错误，并做相关处理*/
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    CLog(@"注册推送功能时错误信息:\n %@", err);
    [[SettingsManager shardSettingsManager] setOpenNotification:NO];
    
}

//程序处于启动状态，或者在后台运行时，会接收到推送消息，解析处理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    CLog(@"运行中收到的推送%@", userInfo);
    //把icon上的标记数字设置为0,
    application.applicationIconBadgeNumber = 0;
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL)
    {
        CLog(@"%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    }
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    CLog(@"ios8运行中收到的推送%@", userInfo);
    //把icon上的标记数字设置为0,
    application.applicationIconBadgeNumber = 0;
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL)
    {
        CLog(@"%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    }
}
#pragma mark -收到本地推送
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
}
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
    
}
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    
}
#pragma -mark- -----------友盟分享设置-----------
/*
-(void)youMeng{
    //打开调试log的开关
    [UMSocialData openLog:YES];
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UmengAppkey];
    
    //设置分享到微信
    [UMSocialWechatHandler setWXAppId:@"wxcf929a212d7eb658c111e6febfcsadsa"
                            appSecret:@"c5b05f9f3f35b9f1asdsa"
                                  url:@"http://www.baidu.com"];
    
    //设置分享到新浪微博
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://www.baidu.com"];
    
    //设置分享到QQ+QQ
    [UMSocialQQHandler setQQWithAppId:@"142400468"
                               appKey:@"c739470479874ab601a158208a04f0ba"
                                  url:@"http://www.baidu.com"];
    [UMSocialQQHandler setSupportWebView:YES];
    
    
}

#pragma -mark  友盟回调
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
#pragma -mark  友盟跳转设置
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}
*/
#pragma mark - -----------系统方法-----------
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}


#pragma mark - -----------系统数据库CoreData-----------
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark  Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"JiujinApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"JiujinApp.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark  Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
