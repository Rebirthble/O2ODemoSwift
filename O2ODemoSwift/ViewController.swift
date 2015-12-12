//
//  ViewController.swift
//  O2ODemoSwift
//
//  Created by 大川雄生 on 2015/12/12.
//  Copyright © 2015年 OkawaUki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var manager : NotificationManager = NotificationManager.init()
    
    @IBAction func setLocation(sender: AnyObject) {
        let locationId = "LOCATION_ID"
        let callback = {(error: NSError?) -> Void in
            if ((error) != nil) {
                print("error: " + (error?.description)!)
            } else {
                print("no error!")
            }
        }
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

