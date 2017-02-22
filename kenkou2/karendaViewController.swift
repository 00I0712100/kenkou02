//
//  karendaViewController.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2017/01/11.
//  Copyright © 2017年 高橋知子. All rights reserved.
//

import UIKit
import JBDatePicker
import RealmSwift

class karendaViewController: UIViewController, JBDatePickerViewDelegate {
    
    @IBOutlet var datePicker: JBDatePickerView!
    @IBOutlet var writeButton: UIButton!

    
        
    var date: String = ""
    
    lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        datePicker.updateLayout()
    }
    
    func didSelectDay(_ dayView: JBDatePickerDayView) {
        print("date selected: \(dateFormatter.string(from: dayView.date!))")
         date = dateFormatter.string(from: dayView.date!) //追加
    }
    
    // （中略）
    
    @IBAction func saveButtonPushed(_ sender: UIButton) {
        
        // STEP.1 Realmを初期化
        let realm = try! Realm()
        
        //STEP.2 保存する要素を書く
        let diary = Diary()
        diary.date = date
        
        
        //STEP.3 Realmに書き込み
        try! realm.write {
            realm.add(diary)
        }
        
        
        //画面遷移して前の画面に戻る
        self.dismiss(animated: true, completion: nil)
        
    }

    
    @IBAction func writeButtonPushed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toDiary", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDiary") {
            let diaryView = segue.destination as! dairyViewController
            diaryView.date = self.date
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
