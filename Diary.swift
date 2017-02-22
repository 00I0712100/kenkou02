
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

    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
