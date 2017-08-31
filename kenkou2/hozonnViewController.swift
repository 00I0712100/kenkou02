//
//  hozonnViewController.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2016/12/23.
//  Copyright © 2016年 高橋知子. All rights reserved.
//

import UIKit
import RealmSwift

class hozonnViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var titleTextFieldsyokuhinn: UITextField!
    @IBOutlet weak var titleTextFieldkarori: UITextField!
    
    
    
    let saveData = UserDefaults.standard
    let realm = try! Realm()
    
    var syokuhins: [String] = []
    var karoris: [String] = []
    var atai: Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //titleTextFieldsyokuhinn.text = saveData.object(forKey: "syokuhinn") as! String?
        // titleTextFieldkarori.text = saveData.object(forKey: "karori-") as! String?
        titleTextFieldkarori.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let syoku = saveData.array(forKey: "syokuhins") as? [String] {
            syokuhins = syoku
            //カロリーも同様にやる
            
        }
        
        if let karo = saveData.array(forKey: "karoris") as? [String] {
            karoris = karo
        }
    }
    
    @IBAction func save(){
        if titleTextFieldsyokuhinn.text == "" || titleTextFieldkarori.text == "" {
            
            let alert = UIAlertController(title: "入力", message: "入力してください", preferredStyle: .alert)
            
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style:.cancel,
                    handler: {action in
                        NSLog("OKボタンが押されました!")
                }
            ))
            present(alert, animated: true, completion: nil)
            
            
        }else{
            
            let syokuhin = Syokuhin()
            
            
            syokuhin.name = titleTextFieldsyokuhinn.text!
            syokuhin.calory = Int(titleTextFieldkarori.text!)!
            syokuhin.id = Syokuhin.lastId()
            
            if let syokuji = realm.objects(Syokuji.self).filter("hiduke >=%d" , dayBegin()).filter("hiduke <=%d" ,dayFinishi()).first{
                
                try! realm.write {
                    if atai == 1 {
                        syokuji.asa.append(syokuhin)
                    }else if atai == 2 {
                        syokuji.hiru.append(syokuhin)
                    }else if atai == 3 {
                        syokuji.yoru.append(syokuhin)
                    }
                    realm.add(syokuji, update: true)
                }
                self.showAlert(syokuji: syokuji)
            }else{
                let syokuji = Syokuji()
                syokuji.id = Syokuji.lastId()
                if atai == 1 {
                    syokuji.asa.append(syokuhin)
                }else if atai == 2 {
                    syokuji.hiru.append(syokuhin)
                }else if atai == 3 {
                    syokuji.yoru.append(syokuhin)
                    
                }
                
                
                
                
                try! self.realm .write {
                    self.realm.add(syokuji)
                }
                
                self.showAlert(syokuji: syokuji)
                
            }
            
        }
        
    }
    func showAlert(syokuji: Syokuji){
        
        let alert = UIAlertController(title: "保存", message: "保存しました", preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style:.cancel,
                handler: {action in
//                    //self.dismiss(animated: true, completion: nil)
//                    let storyboard: UIStoryboard = self.storyboard!
//                    let nextView = storyboard.instantiateViewController(withIdentifier: "nextView") as! PageViewController
//                    nextView.syokuji = syokuji
                    self.dismiss(animated: true, completion: nil)
                    NSLog("OKボタンが押されました!")
                    //self.dismiss(animated: true, completion: nil)
            }
            )
        )
        present(alert, animated: true, completion: nil)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func dayBegin() -> NSDate {
        let date = Date()
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
    func dayFinishi() -> NSDate {
        let date = Date()
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
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
