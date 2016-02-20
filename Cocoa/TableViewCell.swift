//
//  TableViewCell.swift
//  Cocoa
//
//  Created by ShinokiRyosei on 2016/02/16.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
