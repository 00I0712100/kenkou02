//
//  Syokuhin.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2017/05/31.
//  Copyright © 2017年 高橋知子. All rights reserved.
//

import Foundation
import RealmSwift

class Syokuhin: Object {
    
    dynamic var id: Int = 0
    
    
    dynamic var name: String = ""
    dynamic var calory: Int = 0
    dynamic var createdAt: NSDate = NSDate()
    
    override static func primaryKey() -> String{
        return "id"
        
    }
    static func lastId() -> Int{
        let realm = try! Realm()
        if let syokuhin = realm.objects(Syokuhin.self).sorted(byKeyPath: "id", ascending: false).first{
            return syokuhin.id + 1
            
        }else{
            return 1
        }
    }

}
