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
    @IBOutlet var hidukelabel: UILabel!
    @IBOutlet var table02: UITableView!
    @IBOutlet var asa: UILabel!
    @IBOutlet var hiru: UILabel!
    @IBOutlet var yoru: UILabel!
    
    let realm = try! Realm()
    
    
    var syokuji: Syokuji?
    

    var syokuhins: [String] = []
    var karoris:[String] = []
    
        
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
        
        let now = Date() // 現在日時の取得
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale! // ロケールの設定
        dateFormatter.dateFormat = "yyyy.MM.dd" // 日付フォーマットの設定
        
        hidukelabel.text = dateFormatter.string(from: now)

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
        

        syokuji = realm.objects(Syokuji.self).filter("hiduke >=%d" , dayBegin(date: dayView.date!)).filter("hiduke <=%d" , dayFinishi(date: dayView.date!)).first
        
        print(syokuji)
        
    }
    func dayBegin(date: Date) -> NSDate {
        let calendar = Calendar.current
        let component = calendar.dateComponents([.year, .day, .month], from: date)
        let year = component.year!
        let month = String(format: "%02d", component.month!)
        let day = String(format: "%02d", component.day!)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.date(from: "\(year)/\(month)/\(day) 00:00:00")! as NSDate
    }
    
    func dayFinishi(date: Date) -> NSDate {
        let calendar = Calendar.current
        let component = calendar.dateComponents([.year, .day, .month], from: date)
        let year = component.year!
        let month = String(format: "%02d", component.month!)
        let day = String(format: "%02d", component.day!)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.date(from: "\(year)/\(month)/\(day) 23:59:59")! as NSDate
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
