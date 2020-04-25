//
//  ItemSelectionCell.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/25/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit

class ItemSelectionCell: UITableViewCell {

    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
