//
//  nyuryokuViewController.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2017/08/21.
//  Copyright © 2017年 高橋知子. All rights reserved.
//

import UIKit

class nyuryokuViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    
    var numString = ""
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date() // 現在日時の取得
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale! // ロケールの設定
        dateFormatter.dateFormat = "yyyy.MM.dd" // 日付フォーマットの設定
        
        label2.text = dateFormatter.string(from: now)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBAction func num1(){
        numString += "1"
        label.text = numString
    }
    @IBAction func num2(){
        numString += "2"
        label.text = numString
    }
    @IBAction func num3(){
        numString += "3"
        label.text = numString
    }
    @IBAction func num4(){
        numString += "4"
        label.text = numString
    }
    @IBAction func num5(){
        numString += "5"
        label.text = numString
    }
    @IBAction func num6(){
        numString += "6"
        label.text = numString
    }
    @IBAction func num7(){
        numString += "7"
        label.text = numString    }
    @IBAction func num8(){
        numString += "8"
        label.text = numString
    }
    @IBAction func num9(){
        numString += "9"
        label.text = numString
    }
    @IBAction func num0(){
        numString += "0"
        label.text = numString    }
    @IBAction func dot(){
        numString += "."
        label.text = numString    }
    @IBAction func clear(){
        numString = ""
        label.text = numString
    }
    @IBAction func ok(){
        
        //画面遷移して前の画面に戻る
        self.dismiss(animated: true, completion: nil)
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
