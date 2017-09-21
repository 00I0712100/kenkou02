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
                        self.hozon(hosu: self.steps)
                        self.label.text = "steps: \(self.steps)"
                    }
                })
            }
        }
        
        
        
    }
    @IBAction func back(){
        dismiss(animated: true, completion: nil)
    }

    func hozon(hosu: String) {

        let date: Date = Date()
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateString: String = dateFormatter.string(from: date)

        let realm: Realm = try! Realm()
        if let allData: AllData = realm.objects(AllData.self).filter("date == %@", dateString).first {

            try! realm.write {

                allData.hosuData = hosu
                realm.add(allData, update: true)
            }
        }else {

            let allData: AllData = AllData()
            allData.hosuData = hosu
            allData.date = dateString

            try! realm.write {

                realm.add(allData)
            }
        }
    }
    
    @IBAction func ok(){

        //画面遷移して前の画面に戻る


        self.hozon(hosu: self.steps)

    


}

}
