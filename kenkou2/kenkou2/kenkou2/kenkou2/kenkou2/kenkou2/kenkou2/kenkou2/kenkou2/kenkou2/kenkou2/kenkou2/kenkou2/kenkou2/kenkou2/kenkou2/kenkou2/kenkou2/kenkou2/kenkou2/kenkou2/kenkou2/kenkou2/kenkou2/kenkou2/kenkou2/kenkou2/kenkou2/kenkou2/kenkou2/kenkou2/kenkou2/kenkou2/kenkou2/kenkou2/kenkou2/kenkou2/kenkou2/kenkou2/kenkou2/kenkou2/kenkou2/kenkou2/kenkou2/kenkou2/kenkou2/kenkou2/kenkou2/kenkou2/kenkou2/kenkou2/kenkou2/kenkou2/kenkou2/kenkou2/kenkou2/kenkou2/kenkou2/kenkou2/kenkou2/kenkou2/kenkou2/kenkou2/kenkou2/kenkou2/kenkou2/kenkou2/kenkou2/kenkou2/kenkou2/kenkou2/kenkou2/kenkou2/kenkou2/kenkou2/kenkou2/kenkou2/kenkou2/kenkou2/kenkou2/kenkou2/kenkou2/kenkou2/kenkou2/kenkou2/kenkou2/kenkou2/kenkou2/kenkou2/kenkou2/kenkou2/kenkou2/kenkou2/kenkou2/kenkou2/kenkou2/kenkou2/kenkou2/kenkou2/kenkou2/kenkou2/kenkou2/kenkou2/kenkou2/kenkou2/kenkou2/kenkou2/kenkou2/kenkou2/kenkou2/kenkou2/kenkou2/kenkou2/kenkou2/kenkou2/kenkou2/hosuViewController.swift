//
//  ViewController.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2016/11/16.
//  Copyright © 2016年 高橋知子. All rights reserved.
//

import UIKit
import CoreMotion

class hosuViewController: UIViewController {
    
     @IBOutlet var label:UILabel!
    
     let pedometer = CMPedometer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(CMPedometer.isStepCountingAvailable()){
            
            self.pedometer.startUpdates(from: NSDate() as Date) {
                (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        // 歩数
                        let steps = data!.numberOfSteps
                        self.label.text = "steps: \(steps)"
                    }
                })
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

