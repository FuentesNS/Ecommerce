//
//  ProductoCell.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 27/09/22.
//

import UIKit
import SwipeCellKit

class ProductoCell: SwipeTableViewCell {

    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var UnitPriceLabel: UILabel!
    @IBOutlet weak var StockLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var ProductoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let imageData = Data(base64Encoded: image, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
//        ProductoImage.image = UIImage(data: imageData)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
