//
//  hozonnViewController.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2016/12/23.
//  Copyright © 2016年 高橋知子. All rights reserved.
//

import UIKit

class hozonnViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var titleTextFieldsyokuhinn: UITextField!
    @IBOutlet weak var titleTextFieldkarori: UITextField!
    
    
    
    let saveData = UserDefaults.standard
    
    var syokuhins: [String] = []
    var karoris: [String] = []

    
    
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
            
            let syokuji = Syokuji()
            syokuji.asa = 100
            syokuji.hiduke = NSDate()
            syokuji.hiru = 200
            syokuji.yoru = 500
            
            
            //syokuhinsの配列に、titleTextFieldsyokuhinnを追加
            syokuhins.append(titleTextFieldsyokuhinn.text!)
            karoris.append(titleTextFieldkarori.text!)
            
           
            //saveDataにほぞん
            
            saveData.set(syokuhins, forKey: "syokuhins")
            saveData.set(karoris, forKey: "karoris")
            
            print(syokuhins)
            
//            saveData.set(titleTextFieldsyokuhinn.text, forKey:"syokuhinn" )
//            saveData.set(titleTextFieldkarori.text, forKey: "karori-")
            saveData.synchronize()
            
            let alert = UIAlertController(title: "保存", message: "保存しました", preferredStyle: .alert)
            
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style:.cancel,
                    handler: {action in
                        //self.dismiss(animated: true, completion: nil)
                        let storyboard: UIStoryboard = self.storyboard!
                        let nextView = storyboard.instantiateViewController(withIdentifier: "nextView") as! PageViewController
                        nextView.syokuji = syokuji
                        self.present(nextView, animated: true, completion: nil)
                        NSLog("OKボタンが押されました!")
                        //self.dismiss(animated: true, completion: nil)
                }
                )
            )
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
