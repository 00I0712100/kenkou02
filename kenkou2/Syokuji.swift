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
   
    dynamic private var _asaImage: UIImage? = nil
    dynamic var asaImage: UIImage?{
        set{
            self._asaImage = newValue
            if let value = newValue{
                self.asaImageData = UIImagePNGRepresentation(value) as NSData?
            }
        }
        get{
            if let image = self._asaImage{
                return image
            }
            if let data = self.asaImageData{
                 self._asaImage = UIImage(data: data as Data)
                return self._asaImage
            }
            return nil
        }
    }
    dynamic private var asaImageData: NSData? = nil
    
    dynamic private var _hiruImage: UIImage? = nil
    dynamic var hiruImage: UIImage? {
        set{
            self._hiruImage = newValue
            if let value = newValue{
                self.hiruImageData = UIImagePNGRepresentation(value) as NSData?

        }
        }
            get{
                if let image = self._hiruImage{
                    return image
                }
                if let data = self.hiruImageData{
                    self._hiruImage = UIImage(data: data as Data)
                    return self._hiruImage
                }
                return nil

    }
    }
    dynamic private var hiruImageData: NSData? = nil
    
    dynamic private var _yoruImage: UIImage? = nil
    dynamic var yoruImage: UIImage? {
        set{
            self._yoruImage = newValue
            if let value = newValue{
                self.yoruImageData = UIImagePNGRepresentation(value) as NSData?
                
            }
        }
        get{
            if let image = self._yoruImage{
                return image
            }
            if let data = self.yoruImageData{
                self._yoruImage = UIImage(data: data as Data)
                return self._yoruImage
            }
            return nil
            
        }
    }
    dynamic private var yoruImageData: NSData? = nil
    
    override static func ignoredProperties() -> [String] {
        return ["asaImage", "_asaImage", "hiruImage", "_hiruImage", "yoruImage", "_yoruImage"]
    }

    
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

