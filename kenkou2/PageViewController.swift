//
//  ViewController.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2016/12/24.
//  Copyright © 2016年 高橋知子. All rights reserved.
//

import UIKit
import RealmSwift

protocol PageViewControllerDelegate: class {
    func dismiss()
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType, index: Int)
}


class PageViewController: UIViewController, PageViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var hiduke: UILabel!
    
    var pageMenu : CAPSPageMenu?
    
    var backColor :UIColor = UIColor.black
    
    var  syokuji: Syokuji!
    
    var selectedControllerIndex: Int?

    
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
        controller1.delegate = self
        controllerArray.append(controller1)
        
        
        let controller2 = self.storyboard!.instantiateViewController(withIdentifier: "hiru") as! diaryViewController2
        controller2.delegate = self
        controllerArray.append(controller2)
        
        let controller3 = self.storyboard!.instantiateViewController(withIdentifier: "yoru") as! diaryViewController3
        controller3.delegate = self
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
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    func  presentImagePicker(sourceType: UIImagePickerControllerSourceType, index: Int) {
        let controller = UIImagePickerController()
        controller.sourceType = sourceType
        controller.delegate = self
        controller.allowsEditing = true
        self.present(controller, animated: true, completion: {
             self.selectedControllerIndex = index
        })
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        guard let index = selectedControllerIndex else{
            return
        }
        if index == 0{
            let controller = pageMenu?.controllerArray[index] as! dairyViewController
            controller.syokujiimage.image = image
        }else if index == 1{
            let controller = pageMenu?.controllerArray[index] as! diaryViewController2
            controller.syokujiimage.image = image
            
        }else{
            let controller = pageMenu?.controllerArray[index] as! diaryViewController3
            controller.syokujiimage.image = image
        }
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
