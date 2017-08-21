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
    
    var number1: Int = 0
    var number2: Int = 0
    var number3: Int = 0
    var number4: Int = 0

    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func num1(){
        number1 = number1*10 + 1
        label.text = String(number1)
    }
    @IBAction func num2(){
        number1 = number1*10 + 2
        label.text = String(number1)
    }
    @IBAction func num3(){
        number1 = number1*10 + 3
        label.text = String(number1)
    }
    @IBAction func num4(){
        number1 = number1*10 + 4
        label.text = String(number1)
    }
    @IBAction func num5(){
        number1 = number1*10 + 5
        label.text = String(number1)
    }
    @IBAction func num6(){
        number1 = number1*10 + 6
        label.text = String(number1)
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
