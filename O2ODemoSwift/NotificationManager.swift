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
    
    var mLocationManager : CLLocationManager
    
    override init () {
        self.mLocationManager = CLLocationManager.init()
        super.init()
        self.mLocationManager.delegate = self
        
        self.mLocationManager.requestWhenInUseAuthorization()
    }
    
    func searchLocation (locationId: String, callback:(NSError?)->Void) {
        print("locationId: " + locationId)
        callback(NSError(domain: "com.nifty.cloud.mb", code: 1, userInfo: ["message":"fuu error"]))
        
        let location = NCMBObject(className: "Location")
        location.objectId = locationId
        location.fetchInBackgroundWithBlock { (error: NSError!) -> Void in
            if ((error) != nil) {
                print ((error).description)
            } else {
                print ("location name: " + location.objectForKey("name").description)
                let point : NCMBGeoPoint = location.objectForKey("geo") as! NCMBGeoPoint
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
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        let notification = UILocalNotification.init()
        notification.alertBody = "近くでセール開催中！"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.applicationIconBadgeNumber = 1
        
        var region: CLCircularRegion
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(point.latitude, point.longitude)
        region = CLCircularRegion.init(center: location, radius: 50.0, identifier: "SalePoint")
        region.notifyOnExit = false
        
        notification.region = region
        notification.regionTriggersOnce = true
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
}
