//
//  ProductoCollectionViewController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 04/10/22.
//

import UIKit

private let reuseIdentifier = "ProductoCollectionCell"

class ProductoCollectionViewController: UICollectionViewController {

    var productos: [Producto] = []
    var producto = Producto()
    var result = Result()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.collectionView.register(UINib(nibName: "ProductoCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
       
    }

    func LoadData(){
        do{
            result = try! Producto.GetAll()
            if result.Correct!{
                productos = result.Objects as![Producto]
                collectionView.reloadData()
            }
        }catch{
            print("Ocurrio un error")
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return productos.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductoCollectionCell
        
        let producto: Producto = productos[indexPath.row]
        
        cell.NombreLabel.text = producto.Nombre
        cell.PrecioLabel.text = "$\(String(producto.PrecioUnitario!))"
        
        /*
        let productoCell = ProductoCollectionCell()
        producto.IdProducto = productoCell.idProducto
        */
        
        // Configure the cell
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
