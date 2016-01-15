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
    
    override init () {
        
        //プロパティの初期化
        
        super.init()
        
        //CLLocationManagerのデリゲート設定
        
        //位置情報を利用する許可画面を表示

    }
    
    func searchLocation (locationId: String, callback:(NSError?)->Void) {
        
        //Locationクラスを指定したNCMBObjectインスタンスを作成
        
        //引数のlocationIdをインスタンスのobjectIdに設定

        
        //設定されたobjectIdをもとに、データストアからデータを取得
        location.fetchInBackgroundWithBlock { (error: NSError!) -> Void in
            if ((error) != nil) {
                callback(error)
            } else {
                //取得した位置情報をpointに設定
                let point : NCMBGeoPoint = location.objectForKey("geo") as! NCMBGeoPoint
                //Location Notificationを再設定
                self.setLocationNotification(
                    point,
                    callback: { (error : NSError?) -> Void in
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

        //Notificationの再作成

        
        //CLCircularRegionの変数を用意

        
        //regionに設定するCLLocationCoordinate2Dを設定

        
        //リージョンを作成

        
        //リージョンから外に出た場合の通知をOFF

        
        //Notification にリージョンを設定

        
        //通知を一度だけ行う設定

        
        //Notificationをアプリに登録

        
        //コールバックの実行

        
    }
}
