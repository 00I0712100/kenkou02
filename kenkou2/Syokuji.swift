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
    dynamic var asa: Int = 0
    dynamic var hiru: Int = 0
    dynamic var yoru: Int = 0
    
    override static func primaryKey() -> String{
        return "id"
    }
}
