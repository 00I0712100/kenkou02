//
//  ViewController.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2016/11/16.
//  Copyright © 2016年 高橋知子. All rights reserved.
//

import UIKit
import CoreMotion
import RealmSwift

class hosuViewController: UIViewController {
    
     @IBOutlet var label:UILabel!
    
     var pedometer = CMPedometer()
    var steps:String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(CMPedometer.isStepCountingAvailable()){
            
            self.pedometer.startUpdates(from: NSDate() as Date) {
                (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        // 歩数
                        self.steps = String(describing: data!.numberOfSteps)
                        self.label.text = "steps: \(self.steps)"
                    }
                })
            }
        }
        
        
    }
    
    @IBAction func ok(){
        
        //画面遷移して前の画面に戻る
        let realm = try! Realm()
        let allData = AllData()
        
        allData.hosuData = self.steps
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        allData.hosuData = dateFormatter.string(from: Date())
        
        
        allData.hosuData = String(describing: pedometer)
        //nyuryoku.day = label2.text!
        try! realm.write {
            realm.add(allData)
            
            print("aiu")
            
            
            
        }

    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

}
