//
//  ProductoCollectionCell.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 04/10/22.
//

import UIKit
import CoreData

class ProductoCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var NombreLabel: UILabel!
    @IBOutlet weak var PrecioLabel: UILabel!
    @IBOutlet weak var Imagen: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func AddToTheCart() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Carrito", in: context)
        let addProduct = NSManagedObject(entity: entity!, insertInto: context)
        
        //Asignar valor a propiedad de entity
        //addProduct.setValue(NombreLabel.text, forKey: "cantidad")

        do {
          try context.save()
         } catch {
          print("Error saving")
        }
    }
    
}
