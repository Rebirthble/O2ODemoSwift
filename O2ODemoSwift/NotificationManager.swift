//
//  NotificationManager.swift
//  O2ODemoSwift
//
//  Created by 大川雄生 on 2015/12/12.
//  Copyright © 2015年 OkawaUki. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

public class NotificationManager: NSObject, CLLocationManagerDelegate {
    
    //CLLocationManagerクラスのプロパティを用意
    var mLocationManager : CLLocationManager
    
    override init () {
        
        //プロパティの初期化
        self.mLocationManager = CLLocationManager.init()
        
        super.init()
        
        //CLLocationManagerのデリゲート設定
        self.mLocationManager.delegate = self
        
        //位置情報を利用する許可画面を表示
        self.mLocationManager.requestWhenInUseAuthorization()
    }
    
    func searchLocation (locationId: String, callback:(NSError?)->Void) {
        
        //Locationクラスを指定したNCMBObjectインスタンスを作成
        let location = NCMBObject(className: "Location")
        
        //引数のlocationIdをインスタンスのobjectIdに設定
        location.objectId = locationId
        
        //設定されたobjectIdをもとに、データストアからデータを取得
        location.fetchInBackgroundWithBlock { (error: NSError!) -> Void in
            if ((error) != nil) {
                print ((error).description)
            } else {
                
                //取得した位置情報をpointに設定
                let point : NCMBGeoPoint = location.objectForKey("geo") as! NCMBGeoPoint
                
                //Location Notificationを再設定
                self.setLocationNotification(point, callback: { (error : NSError?) -> Void in
                    if ((error) != nil) {
                        callback(error)
                    } else {
                        callback(nil)
                    }
                })
            }
        }
    }
    
    func setLocationNotification (point : NCMBGeoPoint , callback : (NSError?)->Void) {
        
        //以前に登録されたLocation Notificationをすべてキャンセル
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        let notification = UILocalNotification.init()
        notification.alertBody = "近くでセール開催中！"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.applicationIconBadgeNumber = 1
        
        //CLCircularRegionの変数を用意
        var region: CLCircularRegion
        
        //regionに設定するCLLocationCoordinate2Dを設定
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(
            point.latitude,
            point.longitude
        )
        
        //リージョンを作成
        region = CLCircularRegion.init(
            center: location,
            radius: 50.0,
            identifier: "SalePoint"
        )
        
        //リージョンから外に出た場合の通知をOFF
        region.notifyOnExit = false
        
        //Notification にリージョンを設定
        notification.region = region
        
        //通知を一度だけ行う設定
        notification.regionTriggersOnce = true
        
        //Notificationをアプリに登録
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        //コールバックの実行
        callback(nil)
        
    }
}
