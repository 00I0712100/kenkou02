//
//  benri.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2016/12/24.
//  Copyright © 2016年 高橋知子. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(type: T.Type) {
        let nib = UINib(nibName: type.className, bundle: nil)
        register(nib, forCellReuseIdentifier: type.className)
    }
    
    func dequeueCell<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.className, for: indexPath as IndexPath) as? T
    }
    
    func getCell<T: UITableViewCell>(type: T.Type, indexPath: NSIndexPath) -> T? {
        return cellForRow(at: indexPath as IndexPath) as? T
    }
}
