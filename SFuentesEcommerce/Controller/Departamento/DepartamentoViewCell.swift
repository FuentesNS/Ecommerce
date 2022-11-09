//
//  DepartamentoViewCell.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 26/10/22.
//

import UIKit
import SwipeCellKit

class DepartamentoViewCell: SwipeTableViewCell {

    @IBOutlet weak var DepartamentoImage: UIImageView!
    
    @IBOutlet weak var NombreLabel: UILabel!
    @IBOutlet weak var AreaLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
