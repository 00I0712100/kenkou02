//
//  hosuCellTableViewCell.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2017/08/28.
//  Copyright © 2017年 高橋知子. All rights reserved.
//

import UIKit

class hosuCellTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var hosuLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
