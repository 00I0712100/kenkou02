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

class karendaViewController: UIViewController, JBDatePickerViewDelegate, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var datePicker: JBDatePickerView!
    @IBOutlet var writeButton: UIButton!
    @IBOutlet var hidukelabel: UILabel!
    @IBOutlet var table02: UITableView!
    @IBOutlet var asa: UILabel!
    @IBOutlet var hiru: UILabel!
    @IBOutlet var yoru: UILabel!
    
    let realm = try! Realm()
    
    
    

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
    }
    
    // （中略）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return karoris.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: hozonnCell.self, indexPath: indexPath as NSIndexPath)!
        cell.karorilabel.text =  karoris[indexPath.row]
        cell.syokuhinlabel.text =  syokuhins[indexPath.row]
        cell.backgroundColor = UIColor.clear
        
        print(syokuhins)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
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
