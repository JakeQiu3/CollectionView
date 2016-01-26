//
//  AppDelegate.m
//  瀑布流
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 QSY. All rights reserved.
//

#import "AppDelegate.h"
#import "ImagesCollectionViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
// CollectionView的布局
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;//行间隔
    layout.minimumInteritemSpacing = 10;//列间隔
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);//分区的四周布局
#warning item的大小: 多由屏幕的宽-边距-行间距来定，而不是一个固定值。
    layout.itemSize = CGSizeMake(150, 100);//item的大小:    //
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//滚动方向，但行列发生倒置
    layout.headerReferenceSize = CGSizeMake(30, 30);//页眉
    layout.footerReferenceSize = CGSizeMake(30, 30);//页脚
    
    
#warning  CollectionViewController 必须初始化以layout
    ImagesCollectionViewController *imageCVC = [[ImagesCollectionViewController alloc] initWithCollectionViewLayout:layout];
    self.window.rootViewController = imageCVC;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
