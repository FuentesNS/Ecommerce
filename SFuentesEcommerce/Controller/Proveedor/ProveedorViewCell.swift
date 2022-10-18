//
//  ProveedorViewCell.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 17/10/22.
//

import UIKit
import SwipeCellKit

class ProveedorViewCell: SwipeTableViewCell {

    
    @IBOutlet weak var NombreLabel: UILabel!
    @IBOutlet weak var TelefonoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
