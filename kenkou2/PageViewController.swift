//
//  ViewController.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2016/12/24.
//  Copyright © 2016年 高橋知子. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    @IBOutlet weak var hiduke: UILabel!
    
    var pageMenu : CAPSPageMenu?
    
    var backColor :UIColor = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date() // 現在日時の取得
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale! // ロケールの設定
        dateFormatter.dateFormat = "yyyy.MM.dd" // 日付フォーマットの設定
        
        hiduke.text = dateFormatter.string(from: now)
        
        self.title = "PageMenu"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        // 表示するコントローラー
        var controllerArray : [UIViewController] = []
        
        let controller1 = self.storyboard!.instantiateViewController(withIdentifier: "diary") as! dairyViewController
        controllerArray.append(controller1)
        
        let controller2 = self.storyboard!.instantiateViewController(withIdentifier: "hiru") as! diaryViewController2
        controllerArray.append(controller2)
        
        let controller3 = self.storyboard!.instantiateViewController(withIdentifier: "yoru") as! diaryViewController3
        controllerArray.append(controller3)
        
        controller1.title = "朝"
        controller2.title = "昼"
        controller3.title = "夜"
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .scrollMenuBackgroundColor(UIColor(hexString: "#5FC1C6")!),
            .viewBackgroundColor (UIColor(hexString: "#5FC1C6")!)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 50.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
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
