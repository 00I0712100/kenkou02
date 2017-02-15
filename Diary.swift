//
//  Diary.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2017/01/11.
//  Copyright © 2017年 高橋知子. All rights reserved.
//

import Foundation
import RealmSwift

class Diary: Object {
    
    dynamic var date = ""
    dynamic var context = ""
    dynamic var photo: NSData? = nil

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
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
