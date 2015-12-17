//
//  ViewController.swift
//  O2ODemoSwift
//
//  Created by 大川雄生 on 2015/12/12.
//  Copyright © 2015年 OkawaUki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //NotificationManagerのプロパティ作成
    var manager : NotificationManager = NotificationManager.init()
    
    //ボタンが押された時の処理
    @IBAction func setLocation(sender: AnyObject) {
        
        let locationId = "YOUR_LOCATION_ID"
        let callback = {(error: NSError?) -> Void in
            if ((error) != nil) {
                print("error: \(error?.localizedDescription)")
            } else {
                print("no error!")
            }
        }
        
        //設定したlocationIdをもとに位置情報の検索とプッシュ通知の再設定を行う
        manager.searchLocation(locationId, callback: callback)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

