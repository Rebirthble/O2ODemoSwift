//
//  AppDelegate.swift
//  O2ODemoSwift
//
//  Created by 大川雄生 on 2015/12/12.
//  Copyright © 2015年 OkawaUki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var manager : NotificationManager = NotificationManager.init()

    func application(
        application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //SDKの初期化
        NCMB.setApplicationKey(
            "YOUR_APPLICATION_KEY",
            clientKey: "YOUR_CLIENT_KEY"
        )
            
        //プッシュ通知のタイプを設定
        let settings = UIUserNotificationSettings.init(
            forTypes: [.Alert, .Badge, .Sound],
            categories: nil
        )
        
        //プッシュ通知の設定をアプリに登録して、許可画面を表示する
        application.registerUserNotificationSettings(settings)
            
        //リモートプッシュ通知を受信するためのdeviceTokenを要求する
        application.registerForRemoteNotifications()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //deviceToken がAPNsから発行されるとタイミングで呼び出される
    func application(
        application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
            
        //新規でNCMBInstallationのインスタンスを作成
        //または、保存済みの端末情報の取得
        let installation = NCMBInstallation.currentInstallation()
        
        //deviceTokenを設定
        installation.setDeviceTokenFromData(deviceToken)
        
        //端末情報の保存または更新
        installation.saveInBackgroundWithBlock { (error : NSError!) -> Void in
            if ((error) != nil) {
                print("error: \(error?.localizedDescription)")
            } else {
                print ("installation is saved.")
            }
        }
    }
    
    //リモートプッシュ通知を受信すると呼び出される
    func application(
        application: UIApplication,
        didReceiveRemoteNotification userInfo: [NSObject : AnyObject],
        fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        //ペイロードからlocationIdを取得
        let locationId = userInfo["locationId"] as! String
        
            
        if (!locationId.isEmpty) {
            
            //位置情報の検索と、Location Notificationの再設定
            manager.searchLocation(
                locationId,
                callback: { (error: NSError?) -> Void in
                    
                if ((error) != nil) {
                    print("error: \(error?.localizedDescription)")
                }
                completionHandler(.NewData)
            })
        }
    }


}

