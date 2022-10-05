//
//  UsuarioCell.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 23/09/22.
//

import UIKit
import SwipeCellKit

class UsuarioCell: SwipeTableViewCell {

    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var FirstNameLabel: UILabel!
    @IBOutlet weak var LastNameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var UserNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
