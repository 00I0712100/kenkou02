//
//  SyokujiFile.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2017/03/08.
//  Copyright © 2017年 高橋知子. All rights reserved.
//

import Foundation
import RealmSwift

class Syokuji: Object {
    
    dynamic var id: Int = 0
    dynamic var hiduke: NSDate = NSDate()
    
    var asa = List<Syokuhin>()
    var hiru = List<Syokuhin>()
    var yoru = List<Syokuhin>()
   
    
    
    override static func primaryKey() -> String{
        return "id"
        
    }
    static func lastId() -> Int{
        let realm = try! Realm()
        if let syokuji = realm.objects(Syokuji.self).sorted(byProperty: "id", ascending: false).first{
            return syokuji.id + 1
            
        }else{
            return 1
        }
    }
}

